class TutorialController < ApplicationController
  before_action :require_user_signed_in
  layout "none"
  def start

  end

  def bank

  end

end