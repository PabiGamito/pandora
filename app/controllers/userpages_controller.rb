class UserpagesController < ApplicationController
  def userevents
  end
  def userpage
    @user_id=1 #1 should be replaced with :id in user/:id
    @user=User.find(@user_id)
  end
end
