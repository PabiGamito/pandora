class Employe < ActiveRecord::Base
  belongs_to :company
  def self.new_employe(category)
    #NOTE: High IQ=170
    case category
    when 1
      name="#{Employe_name.where(first_name: true).sample.name} #{Employe_name.where(first_name: false).sample.name}"
      new_employe=Employe.create(name: name, company_id: @company.id, iq: rand(70..95), efficiency: rand(22..96), focus: rand(5..80), quality: rand(3..50), happiness: rand(50..95), request: true, salery: rand(1000..2000), category: 1)
      #TODO: Update to dertermine min wanted salery based on focus, iq, efficiency...
      #TODO: Add requested salery to user
      new_employe.update(min_salery: min_salery)
    when 2
      name="#{Employe_name.where(first_name: true).sample.name} #{Employe_name.where(first_name: false).sample.name}"
      Employe.create(name: name, company_id: @company.id, iq: rand(95..115), efficiency: rand(30..96), focus: rand(10..85), quality: rand(15..60), happiness: rand(55..96), request: true, salery: rand(1750..3000), category: 2)
    when 3
      name="#{Employe_name.where(first_name: true).sample.name} #{Employe_name.where(first_name: false).sample.name}"
      Employe.create(name: name, company_id: @company.id, iq: rand(110..125), efficiency: rand(40..98), focus: rand(20..90), quality: rand(30..75), happiness: rand(60..97), request: true, salery: rand(2750..4500), category: 3)
    when 4
      name="#{Employe_name.where(first_name: true).sample.name} #{Employe_name.where(first_name: false).sample.name}"
      Employe.create(name: name, company_id: @company.id, iq: rand(120..130), efficiency: rand(60..99), focus: rand(40..95), quality: rand(50..90), happiness: rand(70..98), request: true, salery: rand(4000..10000), category: 4)
    when 5
      name="#{Employe_name.where(first_name: true).sample.name} #{Employe_name.where(first_name: false).sample.name}"
      Employe.create(name: name, company_id: @company.id, iq: rand(120..160), efficiency: rand(75..99), focus: rand(60..99), quality: rand(70..99), happiness: rand(75..99), request: true, salery: rand(8500..20000), category: 5)
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
      #for every 75$ of investment in ads you get one employe of category 1
      if investment>=rand(50..100)
        left_investment=investment-75
        investment.update(amount: left_investment)
        Employe.new_employe()
      elsif investment >= 50 && investment > 100
        ad.destroy
      end
    end

    Company.each do |company|
      Employe.where(company_id: company.id).count
      #The higher the employe count is the more likely a company is to get employement requests
    end
  end

end