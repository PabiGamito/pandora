class Users::RegistrationsController < Devise::RegistrationsController
  include ApplicationHelper
  layout "signup_layout", only: [:create, :new]
  def create
    super
  end

  def new
    super
  end

  def edit
    super
  end

  private
  def after_sign_up_path_for(user)
    redirect_to '/tutorial'
  end

end
