class TutorialController < ApplicationController
  before_action :require_user_signed_in
  skip_before_action :verify_authenticity_token
  def start
  	@page_name="Tutorial"
  end

  def tutorial_2
  	@page_name="Tutorial"
  	@companies=Company.where(user_id: current_user.id)
  end

  def tutorial_3
  	@page_name="Tutorial"
  end

  def tutorial_4
    @page_name="Tutorial"
  end

  def new_company
  	company=Company.create(:user_id => params[:user_id], :name => params[:name], :moto => params[:moto], :sector => params[:sector].to_i)
    # Create 3 employes along with company
    Employe.new_employe(1, company)
    Employe.new_employe(2, company)
    Employe.new_employe(2, company)
    redirect_to "/tutorial/2"
  end

  def new_loan
    @company_id=params[:company_id]
    
    if Loan.where(:lender_id => 0, :receiver_id => @company_id).count > 0
      flash[:notice]="You can only have one pending loan from the bank at a time."
      redirect_to '/tutorial/4'
    else

      if params[:amount].to_f <= Company.find(params[:company_id]).sales_turnover*0.1  || params[:amount].to_f<=25000
      @time=params[:repay_time].to_i
      @rate=@time*0.2

      Loan.create(:lender_id => 0, :receiver_id => @company_id, :amount => params[:amount].to_f, :rate => @rate, :repay_time => params[:repay_time].to_f)

      new_transaction=Transaction.create(:company_id => @company_id, :amount => params[:amount].to_f, :description => "#{params[:amount]}$ investment from the bank.", :income => true)
      Company.find(@company_id).process_transaction(new_transaction)

      redirect_to '/tutorial/4'
      else
        if Company.find(params[:company_id]).sales_turnover*0.1 > 25000
          max=Company.find(params[:company_id]).sales_turnover*0.1
        else
          max=25000
        end
        flash[:notice]="The bank is not willing to lend #{Company.find(params[:company_id]).name} more than #{max}$."
        redirect_to '/tutorial/3'
      end

    end
  end

end