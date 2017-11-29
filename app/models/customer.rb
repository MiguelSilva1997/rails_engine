class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.find_all(params)
    where(params)
  end

  def self.find_customer(params)
    find_by(params)
  end
end
