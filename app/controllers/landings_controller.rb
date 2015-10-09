class LandingsController < ApplicationController
  before_action :require_user_signed_in

  def home
    @page_name="Home"
  end
end
