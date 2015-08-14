#Project Pandora
Project Pandora is an open source game finder for people      
    
#Features:
- Find people to:
    + Play a sport at a location
    + Play a video game with <-- Probably has more potential for this
- Finds people with common interests
- Find public events near you
- Displays
- Sends email reminders notifications blah blah blah.
- Ability to accept or deny people
- Expiration for events (timeliness)

#Models:
#- User:
    has_many companies
    has_many shares
    full name:
    username:
    password:
    email:
    profile picture: (using gravatar?)
    friends:
    money:

#- Company
    belongs to user
    Share holders: #{user_id=>stock %}
    

#- Notification:

def company_tranfer(owner)
    
end

#Resources
http://techslides.com/50-javascript-libraries-and-plugins-for-maps
Mailgun API# social-finder
