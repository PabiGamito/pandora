class Employe < ActiveRecord::Base
  belongs_to :company
  def self.new_employe(category, company=@company)
    #NOTE: High IQ=170
    case category
    when 1
      name="#{Employe_name.where(first_name: true).sample.name} #{Employe_name.where(first_name: false).sample.name}"
      iq=rand(70..95)+(rand(0..99)/100)
      new_employe=Employe.create(name: name, company_id: company.id, iq: iq, efficiency: rand(22..96), focus: rand(5..80), quality: rand(3..50), happiness: rand(55..95), request: true, salery: rand(1000..2000), category: 1)
      #TODO: Update to dertermine min wanted salery based on focus, iq, efficiency...
      #TODO: Add requested salery to user
      # new_employe.update(min_salery: min_salery)
    when 2
      name="#{Employe_name.where(first_name: true).sample.name} #{Employe_name.where(first_name: false).sample.name}"
      Employe.create(name: name, company_id: company.id, iq: rand(95..115)+(rand(0..99)/100), efficiency: rand(30..96), focus: rand(10..85), quality: rand(15..60), happiness: rand(60..96), request: true, salery: rand(1750..3000), category: 2)
    when 3
      name="#{Employe_name.where(first_name: true).sample.name} #{Employe_name.where(first_name: false).sample.name}"
      Employe.create(name: name, company_id: company.id, iq: rand(110..125)+(rand(0..99)/100), efficiency: rand(40..98), focus: rand(20..90), quality: rand(30..75), happiness: rand(65..97), request: true, salery: rand(2750..4500), category: 3)
    when 4
      name="#{Employe_name.where(first_name: true).sample.name} #{Employe_name.where(first_name: false).sample.name}"
      Employe.create(name: name, company_id: company.id, iq: rand(120..130)+(rand(0..99)/100), efficiency: rand(70..99), focus: rand(45..95), quality: rand(70..93), happiness: rand(70..98), request: true, salery: rand(4000..10000), category: 4)
    when 5
      name="#{Employe_name.where(first_name: true).sample.name} #{Employe_name.where(first_name: false).sample.name}"
      Employe.create(name: name, company_id: company.id, iq: rand(120..160)+(rand(0..99)/100), efficiency: rand(75..99), focus: rand(70..99), quality: rand(70..99), happiness: rand(75..99), request: true, salery: rand(8500..20000), category: 5)
    end

  end

  def self.employment_request
    # TODO: Make it so if a user invests in other ads also have more employes but less
    # TODO: Make it so that certain types of employes cost more advertizing to get.
    # Searches for all employement ads for category 1 employes

    Ad.where(category: 1).each do |ad|
      #Create a new employe if time is good.
      investment=ad.amount
      @company=Company.find(ad.company_id)      
      if investment>=250
        # For every 10 employee request increment create one more employee per hour
        amount_per_hour=(investment/250/10).to_i
        (amount_per_hour+1).times do
          Employe.new_employe(1, @company)
          # Calculates Left Amount of Investment
          @left_investment=investment-250
        end
        ad.update(:amount => @left_investment)
      else investment<250
        ad.destroy
      end

    end

    Ad.where(category: 2).each do |ad|
      #Create a new employe if time is good.
      investment=ad.amount
      @company=Company.find(ad.company_id)      
      if investment>=500
        left_investment=investment-500
        investment.update(amount: left_investment)
        Employe.new_employe(2)
      elsif investment<500
        ad.destroy
      end
    end

    Ad.where(category: 3).each do |ad|
      #Create a new employe if time is good.
      investment=ad.amount
      @company=Company.find(ad.company_id)      
      if investment>=750
        left_investment=investment-750
        investment.update(amount: left_investment)
        Employe.new_employe(3)
      elsif investment<750
        ad.destroy
      end
    end

    # Company.each do |company|
    #   Employe.where(company_id: company.id).count>
    #   #TODO: The higher the employe count is the more likely a company is to get employement requests
    # end
  end

end