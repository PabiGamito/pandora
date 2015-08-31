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
  end

  def search

  end

  def update_orders
    @company=Company.find(params[:company_id])
    @item=Item.find(params[:item_id])
    @buy_offers=Buy_request.all.sort_by { |req| req.price }
    @sell_offers=Sell_request.all.sort_by { |req| req.price }.reverse
    stock=Stock.find_by(company_id: @company.id, item_id: @item.id)
    if stock==nil || stock.amount==0
      @stock_amount=0
    else
      @stock_amount=stock.amount
    end
    render 'update_orders.js.erb'
  end

  def sell
    item_id=params[:market_id].to_i
    company_id=params[:company_id].to_i
    price=params[:price].to_f
    amount=params[:amount].to_i

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
      new_transaction=Transaction.create(:company_id => oldest_buy_request.company_id, :amount => amount, :description => "#{sold_amount} #{item_name}s bought from #{Company.find(company_id).name}'s stock for #{price}$ per unit.", :income => false, :category => "buy stock")
      Company.find(oldest_buy_request.company_id).process_transaction(new_transaction)

      # Seller Transaction
      new_transaction=Transaction.create(:company_id => company_id, :amount => amount, :description => "#{sold_amount} #{item_name} sold to #{Company.find(oldest_buy_request.company_id).name} for #{price}$ per unit.", :income => true, :category => "sell stock")
      Company.find(company_id).process_transaction(new_transaction)

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
        new_transaction=Transaction.create(:company_id => company_id, :amount => amount, :description => "#{sold_amount} #{item_name}s bought from #{Company.find(oldest_sell_request.company_id).name}'s stock for #{price}$ per unit.", :income => false, :category => "buy stock")
        Company.find(company_id).process_transaction(new_transaction)

        # Seller Transaction
        new_transaction=Transaction.create(:company_id => oldest_sell_request.company_id, :amount => amount, :description => "#{sold_amount} #{item_name} sold to #{Company.find(company_id).name} for #{price}$ per unit.", :income => true, :category => "sell stock")
        Company.find(oldest_sell_request.company_id).process_transaction(new_transaction)

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
    redirect_to '/market'

  end

end #close Class