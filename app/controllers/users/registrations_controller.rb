class Users::RegistrationsController < Devise::RegistrationsController
  include ApplicationHelper
  layout "signup_layout", only: [:create, :new]
  def create
    if User.find_by(username: params[:username])!=nil

    end
    super
    redirect_to '/tutorial'
  end

  def new
    super
  end

  def edit
    super
  end

end
