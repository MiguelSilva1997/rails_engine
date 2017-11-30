class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :unit_price, :item_id, :invoice_id

    def unit_price
      '%.2f' % (object.unit_price.to_f / 100)
    end
end
