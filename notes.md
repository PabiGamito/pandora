#Install:
Get them all

#Problem:
- What if no one owns over 50% of the shares? Who takes decissions?
    + Top 5? stock holders decide togethe one click on stuff he wants to do and it will sumbit a message to the other so they decide what to do.
- Company per country? Or not per country?
- On signup if user creates account but not company needs to delete account
    + if Company.where(:user_id => User.id) == nil : remove User.id
- Check user doesn't change html when they submit post
- Can building company buy directly from building or only from sell?
- 

CREATE A SINGLE INITIALIZE MIGRATION

#Features:
- Create a company
    + Get employes that you have to pay
    + Decide what the company does
    + High End, Mid end or Low end
    + When take over company ask if the user would like the change name to "group name" ex: Pabi Cooperation
    + Company belongs to user if he owns over 50% of shares (look this up)
    + Upgrade company "specs" add machines blah blah => Less employes to do the same thing
    + Specialized in something eg: Building => Does it faster & better
    + Chose what you want to do, build, mine, sell, what element.
    + Have to invest a lot to expand comapny to something else or can buy another company to have everything it has.
- Three Galaxies (Tri-Galaxies <= find good name)
    + Trade periodic table elements
    + Mining
    + Building
    + Selling
- Trading goods
- Raise Money
- Live Stock market <= This will be hard
- Pay an empleye searcher to find effective worker
- When you grow more & more workers will want to join you. You will receive job requests
- Different bill paying dates per company
- Have training makes worker stats increase
- Payed holidays, better work place, increases stats

#Models:
#- User:
    has_many shares
    has_many :companies, :through => :shares
    full name:
    username:
    password:
    email:
    profile picture: (using gravatar?)
    balance: float

#- Company
    has_many shares
    has_many :users, :through => :shares
    belongs to user
    type:
    value:
    ADD all other buiness terms that define a compnay (ex: Market Capita)
    # of employes:
    resources somehow
    monthly bill:
    ADD all the possible upgrades (maybe in another table)
    Logo img:
    Country: (pays taxes of that country)

    #To Add:
    Type: Mining, Builder, Seller, or ALL in ONE?
    Element: integer? 

    Will have to use delayed jobs

#Elements
    worth:
    value:
    more stuff:


#JOINT TABLES
#- Friends (Check if this would work)
    user_id1: integer
    user_id2: integer
    accepted: integer (1:yes or 0:no)
    request: integer (1:yes or 0:no)

#- Shares:
    user_id: integer
    company_id: integer
    owned percentage: float

#- Inbox:
    sender_id:
    receiver_id:
    message: <= learn how to make this with formating.

#- Employes:
    IQ:
    Efficiency:
    Focus:
    Quality: Tech, Finance, Look up the rest
    Happiness:
    Description: Prone to sickness blah blah

#- Notification:
    Use a gem?

#---------------------------------------------------#

#Methods:
    - company_tranfer(owner)
    - user worth(shares, companies) <= will have to work this out
    - 

#---------------------------------------------------#

#Pages:
Signup:
    - Signup page
    - License agrement
    - Create company page:
        + Form: Name, Type, everything to fill up the company database
        + Message you had to borrow $ from the bank to start this company: Shares belong to bank & you can buy them back.
        + You are fowarded to homepage with a tutorial (look on my codepen favs for something to do this)

Home:
    - Small boxes top middle
        + Your Worth
        + # Companies you own
        + 
    - Big boxes bottom middle
        + Top user, have diff filters (total wealth, cash...)
        + Share value of your top 5 companies
        + 
    - Right news box + ads

Company:
    - List of your companies

Invest:

Bank:



#---------------------------------------------------#
#TODO:
- Sidebar page link stay active when on page
- Figure out how to create a migration in rails + add column to rails
- Using user/:id in rails
- Add favorite to event table
- Make flash popup not move everything down.
- Get gravatar
- Make sidebar close on it self when toggled
- A referal system
    + Invited User starts with no need to borrow from bank
    + User gets money?
- Get stuff for linking social media etc
- Redirect to /home if user is signed in
- Use navcolapse for sidebar
- If # ends in .0 do not show decimals
- Sidebar have active tabs (use @page_name)
- Tables
    + Add premium boolean, full name to user table
    + Add salery to comapny table
- When user delets account put company on sale
- Check in controller when creating company that user is allowed to do so.

- Make chat & funding from banks & users
- Get bootstrap js
- Add verify_authenticity_token to prevent forged sumbit posts.
- You have only have one private loan request at a time.
- Add total loaned so far & total repayed to user loan info.
- Edit company to if info is public or not
- Have something in the background running that checks if loan is complete adds new employes to companies... blah, blah, blah
- Get code for profile images instead of image link so the make image bigger plugin doesn't work
- Check all pages have name
- Editable Loans
- Check Loan.repay_loans will work correctly
- http://localhost:3000/find-investors fix the inputs sizes.
- Sidebar closed by default on phone display
- Make it so user can add investment limit. So user do not give them more than they want.
- Add male or female to user
- Make left sidebar scrollable
- Use this: http://www.w3schools.com/jquery/tryit.asp?filename=tryjquery_event_change_ref to make inputted stuff not disappear
- Other companies can offer more money to get other players employees => Creates a notification for compnay
- Add age to employes so that at some point the leave the company to retire
- Find a way a submitting a form without reloading the page
- Make it so paying employes, loans... can be automatic if you have a financer want to but doesn't have to be.
- Create event "Ad has been placed in Local Newspapers, TV..." when make a new ad.
- Make balance and other thing update live/ every 1 sec to database
- Make is so it doesn't save the inputs in the inputs boxes

#PREMIUM:
- Premium users can have more than one company.
- Can purchase special upgrades
- You can buy with real money or fake, have ranks with different perks

#Types of transaction:
- Investment
- "pay employes" Find name

#Glitches:
- Unknown
