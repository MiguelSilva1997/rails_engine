require 'rails_helper'

describe "Merchant Relationships API" do
  before(:each) do
    @merchant = Merchant.create(id: 1, name: "Timmy")
    customer = Customer.create(id: 1, first_name: "Pauly", last_name: "Shore")
    item = Item.create(id: 1, merchant_id: 1, name: 'Sofa')

    good_invoice = @merchant.invoices.create(
      customer: customer,
      merchant: @merchant,
      status: "shipped",
      created_at: '2012-02-27 14:53:59 UTC'
      )
    bad_invoice = @merchant.invoices.create(
      customer: customer,
      merchant: @merchant,
      status: "shipped",
      created_at: '2012-02-27 14:53:59 UTC'
    )

    3.times do
      good_invoice.invoice_items.create(
        item_id: item.id,
        quantity: 2,
        unit_price: 50,
        created_at: '2012-02-27 14:53:59 UTC'
      )
      bad_invoice.invoice_items.create(
        item_id: item.id,
        quantity: 2,
        unit_price: 100,
        created_at: '2012-02-27 14:53:59 UTC'
      )
      end
  end

  context "/api/v1/merchants/:id/items"do
    it "returns a collection of items associated with that merchant" do
      get "/api/v1/merchants/#{@merchant.id}/items"

      merchant_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant_items.count).to eq(1)
      expect(merchant_items.first['name']).to eq("Sofa")
    end
  end

  context "/api/v1/merchants/:id/invoices" do
    it "returns a collection of invoices associated with that merchant from their known orders" do
      get "/api/v1/merchants/1/invoices"

      merchant_invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant_invoices.count).to eq(2)
      expect(merchant_invoices.first['merchant_id']).to eq(1)
    end
  end
end
