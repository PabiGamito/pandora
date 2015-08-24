class Transaction < ActiveRecord::Base
  def self.pay_employes
    Transaction.create(category: )
    t.string   "description"
    t.string   "from"
    t.integer  "company_id"
    t.boolean  "income"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "amount"
    t.integer  "user_id"
    t.string   "category"
  end
end