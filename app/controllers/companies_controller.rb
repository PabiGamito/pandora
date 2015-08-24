class CompaniesController < ApplicationController

  before_action :require_user_signed_in
  skip_before_action :verify_authenticity_token
  layout "application"

  def index
    @companies=Company.where(:user_id => current_user.id)
    @page_name="Your Companies"

    # Checks all user companies has employes or else creates one.
    @companies.each do |company|
      if Employe.where(company_id: company.id)==0
        name="#{Employe_name.where(first_name: true).sample.name} #{Employe_name.where(first_name: false).sample.name}"
        new_employe=Employe.create(name: name, company_id: company.id, iq: rand(65..100), efficiency: rand(22..96), focus: rand(5..80), quality: rand(3..50), happiness: rand(50..95), request: true, category: 1)
      end
    end

  end

  def create
    @company=Company.new(:user_id => params[:user_id], :name => params[:name], :moto => params[:moto], :sector => params[:sector].to_i)
    @company.save
    redirect_to "/companies"
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
  

end