require 'pry'

class Loan < ActiveRecord::Base
  belongs_to :company
  has_many :lenders

  def self.repay_loans
    Loan.all.each do |loan|
      lenders=Lender.where(:loan_id => loan.id)
      receiver=Company.find(loan.receiver_id)

      if loan.lender_id!=0 #if Private Loan
    #Add Money to Investor
      lenders.each do |lender|
        total=(lender.percentage*loan.amount)
        if lender.total_repayed.to_f < (total*(loan.rate/100)+total).to_f
          daily_return = (total*(loan.rate/100)+total)/loan.repay_time
          if lender.company_id!=nil
            investor = Company.find(lender.company_id)
            investor.balance += daily_return
            Company.update(investor.id, :balance => investor.balance)

            #Creates private loan return on investment transaction for company lender
            new_transaction=Transaction.create(:company_id => investor.id, :amount => daily_return, :category => "investment", :description => "#{daily_return}$ return on investment in #{receiver.name}.", :income => true)
            investor.process_transaction(new_transaction)
          elsif lender.user_id !=nil
            investor = User.find(lender.user_id)
            investor.balance += daily_return
            User.update(investor.id, :balance => investor.balance)

            #Creates private loan return on investment transaction for user lender
            new_transaction=Transaction.create(:user_id => investor.id, :amount => daily_return, :category => "investment", :description => "#{daily_return}$ return on investment in #{receiver.name}.", :income => true)
            investor.process_transaction(new_transaction)
          end

          lender.total_repayed += daily_return
          lender.update(total_repayed: lender.total_repayed)

          loan.total_repayed += daily_return
          loan.update(total_repayed: loan.total_repayed)

          #Remove Money from Receiver
          receiver.balance -= daily_return
          Company.update(receiver.id, :balance => receiver.balance)

          # Checks if lender is user or company to perform appropriate task accordingly
          if lender.user_id!=nil
            lending_user=User.find(lender.user_id)
            #Creates private loan repay transaction for user lender
            new_transaction=Transaction.create(:company_id => receiver.id, :amount => daily_return, :category => "investment", :description => "#{daily_return}$ to repay investment from #{lending_user.username}.", :income => false)
            receiver.process_transaction(new_transaction)
          elsif lender.company_id!=nil
            lending_company=Company.find(lender.company_id)
            #Creates private loan repay transaction for company lender
            new_transaction=Transaction.create(:company_id => receiver.id, :amount => daily_return, :category => "investment", :description => "#{daily_return}$ to repay investment from #{lending_company.name}.", :income => false)
            receiver.process_transaction(new_transaction)
          end
        end
      end

      
      else #if bank loan
        #Remove Money from Receiver from bank investment
        daily_loss = (total*(loan.rate/100)+total)/loan.repay_time
        receiver.balance -= daily_loss
        Company.update(receiver.id, :balance => receiver.balance)

        loan.total_repayed += daily_loss
        loan.update(total_repayed: loan.total_repayed)

        #Creates bank loan repay transaction
        new_transaction=Transaction.create(:company_id => receiver.id, :amount => params[:amount].to_f, :category => "investment", :description => "#{daily_loss}$ to repay investment from the bank.", :income => false)
        receiver.process_transaction(new_transaction)

      end

    end
  end

end