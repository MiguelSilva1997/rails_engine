class Merchant < ApplicationRecord
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :items
  has_many :customers, through: :invoices

  def self.find_all(params)
    where(params)
  end

  def self.find_merchant(params)
    find_by(params)
  end

  def self.find_random
    all.sample
  end

  def self.revenue(params = nil, limit = 1)
    Invoice.where(params)
    .merge(Transaction.success)
    .joins(:invoice_items, :transactions)
    .limit(limit)
    .sum("unit_price * quantity")
  end
end
