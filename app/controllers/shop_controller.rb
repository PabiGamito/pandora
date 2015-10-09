class ShopController < ApplicationController
  before_action :require_user_signed_in

  layout "application"

  def payment
  	@page_name="Payment"
  end

  def pricing
  	@page_name="Pricing"
  end

end