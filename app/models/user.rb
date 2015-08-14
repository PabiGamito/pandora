class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :companies
  
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :login
  
  #->Prelang (user_login:devise/username_login_support)
  has_many :posts

  after_initialize :defaults

  def defaults
    self.balance = 25000
    self.premium = false
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.downcase}]).first
    else
      where(conditions).first
    end
  end

  def add_balance(amount)
    self.balance += amount
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


  devise authentication_keys: [:login]
end
