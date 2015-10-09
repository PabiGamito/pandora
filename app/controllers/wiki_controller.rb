class WikiController < ApplicationController

  before_action :require_user_signed_in

  def index
    @page_name="Wiki"
  end

end
