class ShopController < ApplicationController
  before_action :require_user_signed_in

  layout "application"

  def payment
  end

  def pricing
  	
  end

end