require 'rails_helper'

describe "Customer Business Intelligence API" do
  before(:each) do
    @customer = Customer.create(id: 1, first_name: "Pauly", last_name: "Shore")
    merchant_1 = Merchant.create(id: 1, name: "Timmy")
    merchant_2 = Merchant.create(id: 2, name: "Johnny")
    item_1 = Item.create(id:1, merchant_id: 1, name: "Katana")
    item_2 = Item.create(id:2, merchant_id: 2, name: "Nodachi")

    merchant_1_invoice = merchant_1.invoices.create(
      customer: @customer,
      merchant: merchant_1,
      status: "shipped",
      created_at: '2012-02-27 14:53:59 UTC'
    )
    merchant_2_invoice = merchant_2.invoices.create(
      customer: @customer,
      merchant: merchant_2,
      status: "shipped",
      created_at: '2012-02-27 14:53:59 UTC'
    )

    3.times do
      merchant_1_invoice.invoice_items.create(
        item_id: item_1.id,
        quantity: 2,
        unit_price: 50,
        created_at: '2012-02-27 14:53:59 UTC'
      )
      merchant_2_invoice.invoice_items.create(
        item_id: item_2.id,
        quantity: 2,
        unit_price: 50,
        created_at: '2012-02-27 14:53:59 UTC'
      )
    end

    2.times do
      merchant_2_invoice.transactions.create(
        credit_card_number: '666',
        result: "success",
        created_at: '2012-03-27 14:53:59 UTC'
      )
    end

    merchant_1_invoice.transactions.create(
      credit_card_number: '666',
      result: "success",
      created_at: '2012-03-27 14:53:59 UTC'
    )
  end

  context "/api/v1/customers/:id/favorite_merchant" do
    it "returns a merchant where the customer has conducted the most successful transactions" do
      get "/api/v1/customers/1/favorite_merchant"

      customer_favorite = JSON.parse(response.body)
      expect(response).to be_success
      expect(customer_favorite["id"]).to eq(2)
    end
  end
end
