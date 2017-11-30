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
end
