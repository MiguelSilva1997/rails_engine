class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.find_all(params)
    where(params)
  end

  def self.find_customer(params)
    find_by(params)
  end

  def self.favorite_merchant(params)
    merchant = Invoice.where(params)
    .merge(Transaction.success)
    .joins(:transactions)
    .group(:merchant_id)
    .count
    Merchant.find(merchant.key(merchant.values.max))
  end
end
