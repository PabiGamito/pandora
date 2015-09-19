class UserpagesController < ApplicationController

  before_action :require_user_signed_in

  def inbox
    @page_name="Inbox"
  end

  def userpage
  	@user=User.find(params[:id])
  	@company=Company.where(user_id: params[:id])
  end
end
