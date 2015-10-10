class Company < ActiveRecord::Base
  belongs_to :user
  has_many :loans
  has_many :employes

  after_initialize :defaults

  def defaults
    self.balance ||= 0
    self.market ||= false
    self.sales_turnover ||= 0
    self.expenses ||= 0
    self.income ||= 0
    self.market_capita ||= 0
    self.shares ||= 0
  end

  def process_transaction(transaction)
    if transaction.income
      self.balance += transaction.amount
      self.update(balance: self.balance)
    else
      self.balance -= transaction.amount
      self.update(balance: self.balance)
    end
  end

  # def production_speed
  #   production_speed=0
  #   Building.where(company_id: self.id).each do |building|
  #     if Upgrade.find(building.upgrade_id).category==self.specialize
  #       if Upgrade_production.find_by(upgrade_id: building.upgrade_id)!=nil
  #         production_speed=Upgrade_production.speed_per_employee*Employe.where(building_id: building.id).count
  #       end
  #     end
  #   end
  #   return production_speed
  # end

 #Runs automatically by server every so often.
  def self.calculations
    self.all.each do |company|
      # Reset everything to 0 to get the proper results
      income=0
      expenses=0
      company.income=0
      company.expenses=0

      #Calculate income
      Transaction.where(:company_id => company.id, :income => true).each do |transaction|
        if Date.today.beginning_of_week(:monday)>=Time.parse(transaction.created_at.to_s)
          company.income+=transaction.amount
          company.save
        end
      end

      #Calculate expenses
      Transaction.where(:company_id => company.id, :income => false).each do |transaction|
        if Date.today.beginning_of_week(:monday)>=Time.parse(transaction.created_at.to_s)
          company.expenses-=transaction.amount
          company.save
        end
      end
    end
  end

  def weekly_reset

  end

  def specialize_name
    if self.specialize==100
      return "krypotonium"
    elsif self.specialize==101
      return "granor"
    elsif self.specialize==102
      return "stradian"
    elsif self.specialize==200
      return "conductive bion"
    elsif self.specialize==201
      return "crystalized astronite"
    elsif self.specialize==202
      return "morphic xenomite"
    elsif self.specialize==300
      return "transportation"
    elsif self.specialize==301
      return "distribution"
    elsif self.specialize=302
      return "construction"
    end
  end

  def self.generate_production
    # Varibale set at begining of Method
    #Rare Material
    total_hourly_kryptonium_production = 10
    total_kryptonium_multiplicator = 0
    #Common Material
    total_hourly_granor_production = 20000
    total_granor_multiplicator = 0
    #Moderatly Common Meterial
    total_hourly_stradian_production = 5000
    total_stradian_multiplicator = 0

    # Calculate total multiplicator for each mining production
    self.all.each do |company|
      if company.sector == 1
        # Veriable reset for each company loop
        employee_multiplicator = 0
        begin
          Building.where(company_id: company_id, production: true).each do |building|
            Employe.where(building_id: build.id).each do |employee|
              # Quality and IQ mostly matter in office and selling workspace.
              # TODO: Make it so employees working in office & headquaters affect production or something else.
              employee_multiplicator += (employee.efficiency/100 + employee.focus/100 + employee.iq/500)
              if building.name=="granor mine"
                total_granor_multiplicator += employee_multiplicator*Math.sqrt(building.level)
              elsif building.name=="krypotonium mine"
                total_kryptonium_multiplicator += employee_multiplicator*Math.sqrt(building.level)
              elsif building.name=="stradian mine"
                total_stradian_multiplicator += employee_multiplicator*Math.sqrt(building.level)
              end
            end
          end
        rescue
          #If error run this
        end
      end
    end

    # Calculate + generate the recourses mined by the companies
    self.all.each do |company|
      if company.sector == 1
        company_production_multiplicator = 0
        
        begin
          Building.where(company_id: company_id, production: true).each do |building|
            building_multiplicator = 0
            Employe.where(building_id: build.id).each do |employee|
              employee_multiplicator = (employee.efficiency/100 + employee.focus/100 + employee.iq/500)
              building_multiplicator += employee_multiplicator*Math.sqrt(building.level)
            end
            #Update Building Production
            if company.specialize==100
              production=(building_multiplicator/total_kryptonium_multiplicator)*total_hourly_kryptonium_production
            elsif company.specialize==101
              production=(building_multiplicator/total_granor_multiplicator)*total_hourly_granor_production
            elsif company.specialize==102
              production=(building_multiplicator/total_stradian_multiplicator)*total_hourly_stradian_production
            end
            building.update(production_amount: production)
            company_production_multiplicator += building_multiplicator
          end

          #Generate the items produced + Update Company Production
          if company.specialize==100
            production=(company_production_multiplicator/total_kryptonium_multiplicator)*total_hourly_kryptonium_production
            #Generate the production
            item_stock = Stock.find_by(company_id: company.id, item_id: Item.find_by(name: "kryptonium").id)
            if item_stock!=nil
              item_stock.update(amount: item_stock.amount+production)
            else
              Stock.new(company_id: company.id, amount: production, item_id: Item.find_by(name: "kryptonium").id)
            end
          elsif company.specialize==101
            production=(company_production_multiplicator/total_granor_multiplicator)*total_hourly_granor_production
            #Generate the production
            item_stock = Stock.find_by(company_id: company.id, item_id: Item.find_by(name: "granor").id)
            if item_stock!=nil
              item_stock.update(amount: item_stock.amount+production)
            else
              Stock.new(company_id: company.id, amount: production, item_id: Item.find_by(name: "granor").id)
            end
          elsif company.specialize==102
            production=(company_production_multiplicator/total_stradian_multiplicator)*total_hourly_stradian_production
            #Generate the production
            item_stock = Stock.find_by(company_id: company.id, item_id: Item.find_by(name: "stradian").id)
            if item_stock!=nil
              item_stock.update(amount: item_stock.amount+production)
            else
              Stock.new(company_id: company.id, amount: production, item_id: Item.find_by(name: "stradian").id)
            end
          end

          # Update Company Production
          company.update(production: production)

        rescue
          #If error run nothing
        end

      end
    end    

  end

  def self.generate_sales
    self.where(specialize: 301).each do |company|
      # calculate sales based on total workers
    end
  end

end