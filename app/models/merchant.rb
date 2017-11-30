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

  def self.most_revenue(limit = 5)
    joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.success)
    .group("merchants.name")
    .select("merchants.id, merchants.name, sum(quantity * unit_price) AS total_revenue")
    .order("total_revenue DESC")
    .group("merchants.id")
    .limit(limit)
  end

  def self.favorite_customer(params)
    customer = Invoice.where(params)
    .merge(Transaction.success)
    .joins(:transactions)
    .group(:customer_id)
    .count
    Customer.find(customer.key(customer.values.max))
  end

  def self.most_items(limit = 5)
    joins(invoices: [:invoice_items, :transactions])
    .select("merchants.*, sum(invoice_items.quantity) AS most_sold")
    .merge(Transaction.success)
    .order("most_sold DESC")
    .group(:id)
    .limit(limit)
  end
end
