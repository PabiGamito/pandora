class ShopController < ApplicationController
  before_action :require_user_signed_in

  layout "none"

  def payment
  end

end