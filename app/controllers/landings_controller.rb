class LandingsController < ApplicationController
  def index
  end
  def events
    @all_activities = Activity.all
    @all_events = Event.all
  end
  def users
    @users = User.all
  end
  def eventpage
    
  end
end
