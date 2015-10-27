class MarketController < ApplicationController
  before_action :require_user_signed_in
  respond_to :html, :js
  # skip_before_action :verify_authenticity_token

  def json_request?
    request.format.json?
  end

  def index
    @page_name="Global Market"
    @items=Element.all
    @direct_render=false
    if cookies[:company]!=nil && cookies[:good_market] != nil
      if Company.find(cookies[:company]).user_id == current_user.id
        @direct_render=true
        @company=Company.find(cookies[:company])
        @item=Item.find(cookies[:good_market])
      end
    end
  end

  def search

  end

  def refresh_orders
    @company=Company.find(params[:company_id])
    @item=Item.find(params[:item_id])
    @buy_offers=Buy_request.where(item_id: params[:item_id]).sort_by { |req| req.price }.reverse
    @sell_offers=Sell_request.where(item_id: params[:item_id]).sort_by { |req| req.price }
    render 'refresh_orders.js.erb'
  end

  def update_orders
    @company=Company.find(params[:company_id])
    @item=Item.find(params[:item_id])
    @buy_offers=Buy_request.where(item_id: params[:item_id]).sort_by { |req| req.price }.reverse
    @sell_offers=Sell_request.where(item_id: params[:item_id]).sort_by { |req| req.price }
    stock=Stock.find_by(company_id: @company.id, item_id: @item.id)
    if stock==nil || stock.amount==0
      @stock_amount=0
    else
      @stock_amount=stock.amount
    end
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => "Population vs GDP For 5 Big Countries [2009]")
      f.xAxis(:categories => ["United States", "Japan", "China", "Germany", "France"])
      f.series(:name => "GDP in Billions", :yAxis => 0, :data => [14119, 5068, 4985, 3339, 2656])
      f.series(:name => "Population in Millions", :yAxis => 1, :data => [310, 127, 1340, 81, 65])

      f.yAxis [
        {:title => {:text => "GDP in Billions", :margin => 70} },
        {:title => {:text => "Population in Millions"}, :opposite => true},
      ]

      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
      f.chart({:defaultSeriesType=>"column"})
    end

    cookies[:good_market]=@item.id
    cookies[:company]=@company.id

    render 'update_orders.js.erb'
  end

  def sell
    item_id=params[:market_id].to_i
    company_id=params[:company_id].to_i
    price=params[:price].to_f
    amount=params[:amount].to_i
    initial_amount=params[:amount].to_i

    # removes from stock
    seller_stock=Stock.find_by(company_id: company_id, item_id: item_id)
    if seller_stock.amount-amount==0
      seller_stock.destroy
    else
      seller_stock.update(amount: seller_stock.amount-amount)
    end

    # If a buy offer at this price already exists
    buy_requests=Buy_request.where(price: price, item_id: item_id)
    while buy_requests.count>0 && amount>0
      oldest_buy_request=buy_requests.order(:created_at, :id).limit(1).first

      if oldest_buy_request.amount>amount
        oldest_buy_request.update(amount: oldest_buy_request.amount-amount)
        sold_amount=amount

        # Adds to buyer stock
        buyer_stock=Stock.find_by(company_id: oldest_buy_request.company_id, item_id: item_id)
        if buyer_stock==nil
          Stock.create(company_id: oldest_buy_request.company_id, item_id: item_id, amount: sold_amount)
        else
          buyer_stock.update(amount: buyer_stock.amount+sold_amount)
        end

        amount=0
        Item.find(item_id).update(price: price)
      else
        sold_amount=oldest_buy_request.amount
        amount-=oldest_buy_request.amount

        # Adds to buyer stock
        buyer_stock=Stock.find_by(company_id: oldest_buy_request.company_id, item_id: item_id)
        if buyer_stock==nil
          Stock.create(company_id: oldest_buy_request.company_id, item_id: item_id, amount: sold_amount)
        else
          buyer_stock.update(amount: buyer_stock.amount+sold_amount)
        end

        oldest_buy_request.destroy
        Item.find(item_id).update(price: price)
      end

      item_name=Item.find(item_id).name

      # Buyer Transaction
      begin
        new_transaction=Transaction.create(:company_id => oldest_buy_request.company_id, :amount => (initial_amount-amount)*price, :description => "#{sold_amount} #{item_name}s bought from #{Company.find(company_id).name}'s stock for #{price}$ per unit.", :income => false, :category => "global market exchange")
        Company.find(oldest_buy_request.company_id).process_transaction(new_transaction)
      rescue 
         puts "Error company might no longer exist"
      end

      # Seller Transaction
      begin
        new_transaction=Transaction.create(:company_id => company_id, :amount => (initial_amount-amount)*price, :description => "#{sold_amount} #{item_name} sold to #{Company.find(oldest_buy_request.company_id).name} for #{price}$ per unit.", :income => true, :category => "global market exchange")
        Company.find(company_id).process_transaction(new_transaction)
      rescue 
        puts "Error company might no longer exist"
      end

    end

    if amount>0
      Sell_request.create(company_id: company_id, item_id: item_id, price: price, amount: amount, share: false)
    end

    # Updates variables to update market orders
    @company=Company.find(company_id)
    @item=Item.find(item_id)
    @buy_offers=Buy_request.all.sort_by { |req| req.price }
    @sell_offers=Sell_request.all.sort_by { |req| req.price }.reverse
    stock=Stock.find_by(company_id: company_id, item_id: item_id)
    if stock==nil || stock.amount==0
      @stock_amount=0
    else
      @stock_amount=stock.amount
    end
    redirect_to '/market'

  end

  def buy

      item_id=params[:market_id].to_i
      company_id=params[:company_id].to_i
      price=params[:price].to_f
      amount=params[:amount].to_i
      initial_amount=params[:amount].to_i
    if Company.find(company_id).balance > amount*price
      # If a buy offer at this price already exists
      sell_requests=Sell_request.where(price: price, item_id: item_id)
      while sell_requests.count>0 && amount>0
        oldest_sell_request=sell_requests.order(:created_at, :id).limit(1).first

        if oldest_sell_request.amount>amount
          oldest_sell_request.update(amount: oldest_sell_request.amount-amount)
          sold_amount=amount

          # Adds to buyer stock
          buyer_stock=Stock.find_by(company_id: company_id, item_id: item_id)
          if buyer_stock==nil
            Stock.create(company_id: company_id, item_id: item_id, amount: amount)
          else
            buyer_stock.update(amount: buyer_stock.amount+amount)
          end

          amount=0
          Item.find(item_id).update(price: price)
        else
          sold_amount=oldest_sell_request.amount
          amount-=oldest_sell_request.amount

          # Adds to buyer stock
          buyer_stock=Stock.find_by(company_id: company_id, item_id: item_id)
          if buyer_stock==nil
            Stock.create(company_id: company_id, item_id: item_id, amount: sold_amount)
          else
            buyer_stock.update(amount: buyer_stock.amount+sold_amount)
          end

          oldest_sell_request.destroy
          Item.find(item_id).update(price: price)
        end

        item_name=Item.find(item_id).name

        # Buyer Transaction
        begin
          new_transaction=Transaction.create(:company_id => company_id, :amount => (initial_amount-amount)*price, :description => "#{sold_amount} #{item_name}s bought from #{Company.find(oldest_sell_request.company_id).name}'s stock for #{price}$ per unit.", :income => false, :category => "global market exchange")
          Company.find(company_id).process_transaction(new_transaction)
        rescue 
          puts "Error company might no longer exist"
        end

        # Seller Transaction
        begin
          new_transaction=Transaction.create(:company_id => oldest_sell_request.company_id, :amount => (initial_amount-amount)*price, :description => "#{sold_amount} #{item_name} sold to #{Company.find(company_id).name} for #{price}$ per unit.", :income => true, :category => "global market exchange")
          Company.find(oldest_sell_request.company_id).process_transaction(new_transaction)
        rescue 
          puts "Error company might no longer exist"
        end

      end #end of while

      if amount>0
        Buy_request.create(company_id: company_id, item_id: item_id, price: price, amount: amount, share: false)
      end

      flash[:notice]="Successfully created a buy order for #{params[:amount]} #{item_name} at #{price}$ per unit."

    # Updates variables to update market orders
    @company=Company.find(company_id)
    @item=Item.find(item_id)
    @buy_offers=Buy_request.all.sort_by { |req| req.price }
    @sell_offers=Sell_request.all.sort_by { |req| req.price }.reverse
    stock=Stock.find_by(company_id: company_id, item_id: item_id)
    if stock==nil || stock.amount==0
      @stock_amount=0
    else
      @stock_amount=stock.amount
    end
    else
    flash[:notice]="You do not have enought money to buy all that."
    end
    redirect_to '/market'
  end

  def json
    @item=Item.find(params[:id])
  end

end #close Class