class CompaniesController < ApplicationController

  before_action :require_user_signed_in
  skip_before_action :verify_authenticity_token
  layout "application"

  def index
    @companies=Company.where(:user_id => current_user.id)
    @page_name="Your Companies"
  end

  def create
    company=Company.create(:user_id => params[:user_id], :name => params[:name], :moto => params[:moto], :sector => params[:sector].to_i)
    # Create 3 employes along with company
    Employe.new_employe(1, company)
    Employe.new_employe(2, company)
    Employe.new_employe(2, company)
    redirect_to "/companies"
  end

  def update
    session[:return_to] ||= request.referer

    begin
      redirect_to session.delete(:return_to)
    rescue
      redirect_to '/companies'
    end
  end

  def new
    @page_name="Create Company"
  end

  def show
    @company=Company.find(params[:id])
    @page_name=@company.name
  end

  def edit
    session[:return_to] ||= request.referer
    @company=Company.find(params[:id])
    @page_name="Edit #{@company.name}"
    begin
      if @company.user_id!=current_user.id
        redirect_to session.delete(:return_to)
      end
    rescue
      redirect_to '/home'
    end
  end

  def profitandloss
    @page_name = "Profit & Loss"
    # Initialize Variables
  end

  def upgrades
    @page_name="Upgrades"
  end

  def employe_find
    @page_name="Find Employes"
  end
  

# EMPLOYEES
  def hire_employee
    session[:return_to] ||= request.referer
    Employe.find(params[:employee_id]).update(request: false)

    begin
      redirect_to session.delete(:return_to)
    rescue
      redirect_to '/companies'
    end
  end

  def decline_employee
    session[:return_to] ||= request.referer
    Employe.find(params[:employee_id]).destroy

    begin
      redirect_to session.delete(:return_to)
    rescue
      redirect_to '/companies'
    end
  end

  def fire_employee
    session[:return_to] ||= request.referer
    Employe.find(params[:employee_id]).destroy

    begin
      redirect_to session.delete(:return_to)
    rescue
      redirect_to '/companies'
    end
  end

  def employement_ad
    session[:return_to] ||= request.referer

    Ad.create(company_id: params[:company_id].to_i, amount: params[:amount].to_f*250*params[:category].to_i, category: params[:category].to_i)
    company=Company.find(params[:company_id].to_i)
    company.balance-=params[:amount].to_f*250*params[:category].to_i
    company.update(balance: company.balance)

    begin
      redirect_to session.delete(:return_to)
    rescue
      redirect_to '/companies'
    end
  end

end