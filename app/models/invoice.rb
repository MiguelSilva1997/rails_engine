class Invoice < ApplicationRecord
  belongs_to :merchant
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.find_all(params)
    where(params)
  end

  def self.find_invoice(params)
    find_by(params)
  end
end
