class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.find_all(params)
    where(params)
  end

  def self.find_item(params)
    if params[:created_at] || params[:updated_at]
      where(params).order("id ASC").first
    else
      find_by(params)
    end
  end

  def self.most_revenue(limit = 5)
    joins(invoice_items: [invoice: [:transactions]])
    .select('items.*, sum(invoice_items.quantity) AS most_sold')
    .merge(Transaction.success)
    .order('most_sold DESC')
    .group("items.id")
    .limit(limit)
  end

  def self.most_items(limit = 5)
    joins(invoice_items: [invoice: [:transactions]])
    .select("items.*, sum(invoice_items.quantity) AS amount_sold")
    .merge(Transaction.success)
    .order("amount_sold DESC")
    .group("items.id")
    .limit(limit)
  end

  def best_day
    invoices.joins(:transactions)
    .select('invoices.created_at, sum(invoice_items.quantity) AS sold')
    .merge(Transaction.success)
    .group(:id)
    .order('sold desc')
    .first.created_at
  end
end
