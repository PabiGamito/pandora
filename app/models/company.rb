class Company < ActiveRecord::Base
  belongs_to :user
  has_many :loans
  has_many :employes

  after_initialize :defaults

  def defaults
    self.balance = 25000
    self.market = false
    self.sales_turnover = 0
    self.expenses = 0
    self.income = 0
    self.market_capita = 0
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

end