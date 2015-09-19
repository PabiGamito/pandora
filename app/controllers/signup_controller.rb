class SignupController < ApplicationController
  include ApplicationHelper
  before_action :check_signed_in, only: [:index, :signup]
  skip_before_action :verify_authenticity_token, only: [:create_company_post]

  def check_signed_in
    redirect_to home_path if signed_in?
  end
  # before_filter :authenticate_user!
  layout "signup_layout"
  def index
    
  end

  def signup_start

  end

  def create_company

  end

  def create_company_post
    Company.create(:user_id => params[:user_id].to_i, :name => params[:name], :moto => params[:moto])
    redirect_to '/home'
  end

end