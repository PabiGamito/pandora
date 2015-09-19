class Users::SessionsController < Devise::SessionsController
  include ApplicationHelper
  layout "signup_layout"
  def create
    # if params[:login]
    	
    # end
    super
  end

  def new
    super
  end
end
