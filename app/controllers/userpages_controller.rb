class UserpagesController < ApplicationController

  before_action :require_user_signed_in

  def inbox
    @page_name="Inbox"
  end
end
