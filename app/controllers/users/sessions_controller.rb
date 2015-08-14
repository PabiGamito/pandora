class Users::SessionsController < Devise::SessionsController
  include ApplicationHelper
  layout "signup_layout"
  def create
    super
  end

  def new
    super
  end
end
