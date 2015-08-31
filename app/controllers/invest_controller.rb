class InvestController < ApplicationController

  before_action :require_user_signed_in
  skip_before_action :verify_authenticity_token

#---------GET REQUESTS-------#
  def market
    @page_name="Stock Market"
  end

  def investors
    session[:return_to] ||= request.referer

    # Check user owns a company to create load page
    begin
      if Company.where(:user_id => current_user.id).count==0
        redirect_to session.delete(:return_to)
      end
    rescue
      redirect_to '/home'
    end

    @page_name="Find Investors"
  end

  def investments
    @page_name="Investment List"
  end

  def loan
    @loan=Loan.find(params[:id])
    @page_name="Loan"
    @company=Company.find(@loan.receiver_id)
    @user=User.find(@company.user_id)
    @lender_companies=Company.where(:user_id => current_user.id)
  end


#-------POSTS REQUESTS------#
  def investors_submit_bank
    @company_id=params[:company_id]
    
    if Loan.where(:lender_id => 0, :receiver_id => @company_id).count > 0
      flash[:notice]="You can only have one pending loan from the bank at a time."
    else

      if params[:amount].to_f <= Company.find(params[:company_id]).sales_turnover*0.1  || params[:amount].to_f<=25000
      @time=params[:repay_time].to_i
      @rate=@time*0.2

      Loan.create(:lender_id => 0, :receiver_id => @company_id, :amount => params[:amount].to_f, :rate => @rate, :repay_time => params[:repay_time].to_f)

      new_transaction=Transaction.create(:company_id => @company_id, :amount => params[:amount].to_f, :description => "#{params[:amount]}$ investment from the bank.", :category => "Bank Loan",:income => true)
      Company.find(@company_id).process_transaction(new_transaction)

      flash[:notice]="Successfully Created a Loan!"
      else
        if Company.find(params[:company_id]).sales_turnover*0.1 > 25000
          max=Company.find(params[:company_id]).sales_turnover*0.1
        else
          max=25000
        end
        flash[:notice]="The bank is not willing to lend #{Company.find(params[:company_id]).name} more than #{max}$."
      end

    end
    redirect_to '/find-investors'
  end

  def investors_submit_private
    # Checks only one investment is in place

    @company_id=params[:company_id].to_i
    @new_loan=Loan.new(:receiver_id => @company_id, :amount => params[:amount].to_f, :rate => params[:rate].to_f, :repay_time => params[:repay_time].to_f, :pending => 0)
    @new_loan.save
    # flash[:notice]="Successfully Requested a Loan!"

    redirect_to "/loan/#{@new_loan.id}"
  end

  def private_investement
    #session[:return_to] ||= request.referer
    # TODO: Make is so you can invest from company or from user

    @receiving_company=Company.find(params[:company_id].to_i)

    if /(company)\w/.match(params[:invest_with])[0]==params[:invest_with]
      @lender_type="company"
      @lender=params[:invest_with]
    elsif params[:invest_with]=="user"
      @lender_type="user"
      @investor_money=current_user.balance
      @lending_user=current_user
    end

    # Find company
    if @lender_type=="company"
      @possible_companies=Company.where(:user_id => current_user.id)
      n=0
      @possible_companies.each do |company|
        n+=1
        if /([1-9])([0-9])?/.match(params[:invest_with])[0] == n.to_s
          @lending_company=company.id
          @lending_company_object=company
          @investor_money=company.balance
        end
      end
    end


  if params[:amount].to_f <= @investor_money
    # Check if investor already invested in this loan
    @loan=Loan.find(params[:loan_id].to_i)
    @pending_loan=@loan.pending
    if @lender_type=="user"
      #Checks user has not already invested in this loan
      if Lender.where(:loan_id => params[:loan_id].to_i, :user_id => current_user.id).count==0
        @percentage=(params[:amount].to_f)/(params[:loan_amount].to_f)
        Lender.create(:user_id => current_user.id, :loan_id => params[:loan_id].to_i, :percentage => @percentage, :total_repayed => 0)

        @company_name=params[:company]

        @lending_user.balance -= params[:amount].to_f
        User.update(@lending_user.id, :balance => @lending_user.balance)

        @receiving_company.balance += params[:amount].to_f
        Company.update(@receiving_company.id, :balance => @receiving_company.balance)

        @loan.pending+=params[:amount].to_f
        Company.update(@loan.id, :pending => @loan.pending)

        #Create lending user transaction
        new_transaction=Transaction.create(:user_id => @lender.id, :amount => params[:amount].to_f, :category => "investment", :description => "#{params[:amount]}$ investment in #{@receiving_company.name}.", :income => false)
        @lender.process_transaction(new_transaction)
        #Create receiving user transaction
        new_transaction=Transaction.create(:company_id => @receiving_company.id, :amount => params[:amount].to_f, :category => "investment", :description => "#{params[:amount]}$ investment from #{@lending_company_object.name}.", :income => true)
        @receiving_company.process_transaction(new_transaction)

        flash[:notice]="You have Successfully Invested #{params[:amount]} in #{@company_name}!"
      else
        @lender=Lender.find_by(:user_id => current_user.id, :loan_id => @loan.id)
        @lender_amount=@lender.percentage*@loan.amount
        @company_name=params[:company]

        @new_percentage=(@lender_amount+params[:amount].to_f)/@loan.amount
        @lender.percentage=@new_percentage
        Lender.update(@lender.id, :percentage => @lender.percentage)

        @loan.pending += params[:amount].to_f
        Loan.update(@loan.id, :pending => @loan.pending)

        @lending_user.balance -= params[:amount].to_f
        User.update(@lending_user.id, :balance => @lending_user.balance)

        @receiving_company.balance += params[:amount].to_f
        Company.update(@receiving_company.id, :balance => @receiving_company.balance)

        #Create lending user transaction
        new_transaction=Transaction.create(:user_id => @lender.id, :amount => params[:amount].to_f, :category => "investment", :description => "#{params[:amount]}$ investment in #{@receiving_company.name}.", :income => false)
        @lender.process_transaction(new_transaction)
        #Create receiving user transaction
        new_transaction=Transaction.create(:company_id => @receiving_company.id, :amount => params[:amount].to_f, :category => "investment", :description => "#{params[:amount]}$ investment from #{@lending_company_object.name}.", :income => true)
        @receiving_company.process_transaction(new_transaction)

        flash[:notice]="You have Successfully Invested #{params[:amount]} in #{@company_name}!"
      end

    elsif @lender_type=="company"
      #Checks if company has not already invested in this loan
      if Lender.where(:loan_id => params[:loan_id].to_i, :company_id => @lending_company).count==0
        @percentage=(params[:amount].to_f)/(params[:loan_amount].to_f)
        Lender.create(:company_id => @lending_company, :loan_id => params[:loan_id].to_i, :percentage => @percentage, :total_repayed => 0)
        @company_name=params[:company]

        @loan.pending += params[:amount].to_f
        @loan.update(pending: @loan.pending)

        @lending_company_object.balance -= params[:amount].to_f
        @lending_company_object.update(balance: @lending_company_object.balance)

        @receiving_company.balance += params[:amount].to_f
        @receiving_company.update(balance: @receiving_company.balance)

        #Create lending user transaction
        new_transaction=Transaction.create(:company_id => @lending_company_object.id, :amount => params[:amount].to_f, :category => "investment", :description => "#{params[:amount]}$ investment in #{@receiving_company.name}.", :income => false)
        @lending_company_object.process_transaction(new_transaction)
        #Create receiving user transaction
        new_transaction=Transaction.create(:company_id => @receiving_company.id, :amount => params[:amount].to_f, :category => "investment", :description => "#{params[:amount]}$ investment from #{@lending_company_object.name}.", :income => true)
        @receiving_company.process_transaction(new_transaction)

        flash[:notice]="You have Successfully Invested #{params[:amount]} in #{@company_name}!"
      else
        @lender=Lender.find_by(:company_id => @lending_company, :loan_id => @loan.id)
        @lender_amount=@lender.percentage*@loan.amount
        @new_percentage=(@lender_amount+params[:amount].to_f)/@loan.amount

        @lender.percentage=@new_percentage
        @lender.update(percentage: @lender.percentage)

        @company_name=params[:company]

        @loan.pending += params[:amount].to_f
        @loan.update(pending: @loan.pending)

        @lending_company_object.balance -= params[:amount].to_f
        @lending_company_object.update(balance: @lending_company_object.balance)

        @receiving_company.balance += params[:amount].to_f
        @receiving_company.update(balance: @receiving_company.balance)

        #Create lending user transaction
        new_transaction=Transaction.create(:company_id => @lending_company_object.id, :amount => params[:amount].to_f, :category => "investment", :description => "#{params[:amount]}$ investment in #{@receiving_company.name}.", :income => false)
        @lending_company_object.process_transaction(new_transaction)
        #Create receiving user transaction
        new_transaction=Transaction.create(:company_id => @receiving_company.id, :amount => params[:amount].to_f, :category => "investment", :description => "#{params[:amount]}$ investment from #{@lending_company_object.name}.", :income => true)
        @receiving_company.process_transaction(new_transaction)
        
        flash[:notice]="You have Successfully Invested #{params[:amount]} in #{@company_name}!"
      end
    end
  else
    flash[:notice]="You can not invested more than you have!"
  end
    redirect_to "/loan/#{@loan.id}"
  end

end
