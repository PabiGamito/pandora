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
    has_many projects
    belongs to projects (joint table)
    full name:
    username:
    password:
    email:
    profile picture: (using gravatar?)
    age: 
    social contact: (fb, skype, phone #, )
    passions/interests:
    friends:
    rating: you don't want to find yourself with bad people
    profile-img:
    city:
    zip:
    address(private):
    latitude:
    longitude:

#- Activity:
    has_many users (participating users)
    belongs to user (owner of event)
    activity/event:
    time/date:
    location: (uses google maps to pinpoint coordenates)
    public: boolean (private or public invite)
    (maybe hidden, private & public invite)
    should have an expiration

#- Event:
    has_many activities
    name:
    host_id:
    event_date:
    public:
    latitude:
    longitude:
    img: should auto crop to format

#- Userevent (links users & events):
    user_id
    event_id

#- Activity (linked to Event):
    activity_name

#- Invitation:
    event_id:
    user_id:
    host_id:

#- Notification:

#Resources
http://techslides.com/50-javascript-libraries-and-plugins-for-maps
Mailgun API# social-finder
