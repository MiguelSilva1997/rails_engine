class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  def self.find_all(params)
    params['unit_price'] = (params["unit_price"].to_f * 100) if params['unit_price']
    where(params)
  end

  def self.find_invoice_item(params)
    params['unit_price'] = (params["unit_price"].to_f * 100) if params['unit_price']
    find_by(params)
  end
end
