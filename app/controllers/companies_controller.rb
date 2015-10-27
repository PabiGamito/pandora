class CompaniesController < ApplicationController

  before_action :require_user_signed_in, :onload_check
  # skip_before_action :verify_authenticity_token
  layout "application"

  def onload_check
    begin
      if cookies[:company]==nil
        cookies[:company]=Company.find_by(user_id: current_user.id).id
      end
      if Company.find(cookies[:company]).user_id==current_user.id
        @company=Company.find(cookies[:company])
      else
        cookies[:company]=Company.find_by(user_id: current_user.id).id
      end
    rescue
      cookies[:company]=Company.find_by(user_id: current_user.id).id
    end
    @company=Company.find(cookies[:company])
  end

  def index
    @companies=Company.where(user_id: current_user.id, main: true)
    @page_name="Your Companies"
    # cookies[:company]=Company.find_by(user_id: current_user.id).id
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

    Building.create(company_id: company.id, name: "offices", level: 1)
    Building.create(company_id: company.id, name: "headquarter", level: 1)

    if params[:specialize].to_i < 200
      Building.create(company_id: company.id, name: "mine", level: 1)
    elsif params[:specialize].to_i < 300
      Building.create(company_id: company.id, name: "factories", level: 1)
    elsif params[:specialize].to_i < 400
      if params[:specialize].to_i == 300 #Transportation
        Building.create(company_id: company.id, name: "trucks", level: 1)
      elsif params[:specialize].to_i == 301 #Distribution
        Building.create(company_id: company.id, name: "shops", level: 1)
      elsif params[:specialize].to_i == 302 #Construction
        Building.create(company_id: company.id, name: "shops", level: 1)
      end
    end
    cookies[:company]=company.id
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
    if Company.find(employee.company_id).user_id==current_user.id
      employee.update(request: false)
      flash[:notice] = "#{employee.name} has been hired."
    else
      flash[:notice] = "An error has occurred."
    end
    render :nothing => true
  end

  def decline_employee
    employee=Employe.find(params[:employee_id])
    if Company.find(employee.company_id).user_id==current_user.id
      employee.destroy
      flash[:notice] = "#{employee.name} has been declined a job position."
    else
      flash[:notice] = "An error has occurred."
    end
    render :nothing => true
  end

  def fire_employee
    employee=Employe.find(params[:employee_id])
    company=Company.find(employee.company_id)
    amount=employee.salery*3

    new_transaction=Transaction.create(:company_id => @company_id, :amount => amount, :description => "#{amount}$ to fire #{employee.name}.", :category => "Employee Salery",:income => false)
    company.process_transaction(new_transaction)

    employee.destroy
    flash[:notice] = "#{employee.name} has been fired. You have payed him #{amount}$ to leave your company."
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

  def update_employee_building
    @buildings=Building.where(company_id: params[:company_id], name: params[:building_name])
    @buildings.each do |building|
      n=0
      building_employees=0 #Max number of worker that can work in total of buildings of specific type
      level=0 #Level of Building
      while level<building.level
        if n<(building.level/10).to_i
          n+=1
          building_employees+=10*n
          level+=10
        elsif n==(building.level/10).to_i
          building_employees+=n+1
          level+=1
        end
      end
    end

    if Employee.where(company_id: params[:company_id], building_id: building.id).count < building_employees
      #Employe.find(params[:employee_id]).update(building_id: building that is not full id)
    else
      # Building full please upgrade 
    end
  end

# Build
  def build
    @company=Company.find(params[:company_id])

    if @company.balance >= 10000


      @company.update(balance: @company.balance-10000) #TODO REPLACE 1000 with construction company price

    else
      # NOTIFICAITON: You do not have enough money.
      flash[:notice] = "You do not have enough money to build a params[:building_name]."

    end

    @render="Build"
    render 'load_dropdown.js.erb'

  end

  def change_fee
    if Company_fee.find_by(company_id: @company.id) == nil
      Company_fee.create(company_id: @company.id, fee: params[:fee], sector: @company.specialize)
    else
      Company_fee.find_by(company_id: @company.id).update(fee: params[:fee])
    end
  end

end