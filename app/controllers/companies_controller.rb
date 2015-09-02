class CompaniesController < ApplicationController

  before_action :require_user_signed_in
  # skip_before_action :verify_authenticity_token
  layout "application"

  def index
    @companies=Company.where(user_id: current_user.id, main: true)
    @page_name="Your Companies"
  end

  def load_dropdown
    @company=Company.find(params[:company_id])
    @render=params[:render]
    render 'load_dropdown.js.erb'
  end

  def create
    company=Company.create(:user_id => params[:user_id], :name => params[:name], :moto => params[:moto], :sector => params[:sector].to_i, :main => true, :specialize => params[:specialize].to_i)
    # Create 3 employes along with company
    Employe.new_employe(1, company)
    Employe.new_employe(2, company)
    Employe.new_employe(2, company)
    redirect_to "/companies"
  end

  def create_sector
    company=Company.create(:user_id => params[:user_id], :name => params[:name], :moto => params[:moto], :sector => params[:sector].to_i, :main => false, :specialize => params[:specialize].to_i)
    Company_sector.create(company_id: company.id, owner_company_id: params[:company_id])
    # Create 3 employes along with company
    Employe.new_employe(1, company)
    Employe.new_employe(2, company)
    Employe.new_employe(2, company)
    redirect_to "/companies"
  end

  def upgrade
    Upgrade_level.find_by(company_id: params[:company_id], upgrade_value: params[:upgrade]).update(level: params[:level])
    @company=Company.find(params[:company_id])
    @render="Upgrade"
    render 'load_dropdown.js.erb'
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
    employee=Employe.find(params[:employee_id])
    employee.update(request: false)
    flash[:notice] = "#{employee.name} has been hired."
  end

  def decline_employee
    Employe.find(params[:employee_id]).destroy
  end

  def fire_employee
    Employe.find(params[:employee_id]).destroy
    flash[:notice] = "#{employee.name} has been fired."
  end

  def employement_ad
    session[:return_to] ||= request.referer

    company = Company.find(params[:company_id].to_i)
    ad_price = params[:amount].to_f*250*params[:category].to_i
    # Checks company has enough money for the ad.
    if company.balance >= ad_price
      Ad.create(company_id: params[:company_id].to_i, amount: params[:amount].to_f*250*params[:category].to_i, category: params[:category].to_i)
      company.balance-=params[:amount].to_f*250*params[:category].to_i
      company.update(balance: company.balance)
    else
      flash[:notice] = "You do not have enough money to create this ad."
    end

    begin
      redirect_to session.delete(:return_to)
    rescue
      redirect_to '/companies'
    end

  end

end