require 'rails_helper'

describe "Transaction Relationships API" do
  before (:each) do
    @merchant = Merchant.create(id: 1, name: "Toki")
    customer = Customer.create(id: 1, first_name: "Skwisgar", last_name: "Skwigelf")
    item_1 = Item.create(id:1, merchant_id: 1, name: "Wartooth")
    item_2 = Item.create(id:2, merchant_id: 1, name: "Guitar")
    item_3 = Item.create(id:3, merchant_id: 1, name: "Metal")
    invoice_1 = @merchant.invoices.create(
      id:1,
      customer: customer,
      merchant: @merchant,
      status: "shipped",
      created_at: '2012-03-27 14:53:59 UTC'
    )

    3.times do
      invoice_1.invoice_items.create(
        item_id: item_1.id,
        quantity: 4,
        unit_price: 50
      )
    end
    invoice_1.transactions.create(
      id: 1,
      credit_card_number: '666',
      result: "success",
      created_at: '2012-03-27 14:53:59 UTC'
    )
  end

  context "/api/v1/transactions/:id/invoice" do
    it "returns the associated invoice" do
       get "/api/v1/transactions/1/invoice"

       transaction_invoice = JSON.parse(response.body)

       expect(response).to be_success
       expect(transaction_invoice['id']).to eq(1)
    end
  end
end
