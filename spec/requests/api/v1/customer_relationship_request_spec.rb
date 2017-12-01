require 'rails_helper'

describe "Customer Relationships API" do
  before (:each) do
    @merchant = Merchant.create(id: 1, name: "Toki")
    customer = Customer.create(id: 1, first_name: "Skwisgar", last_name: "Skwigelf")
    item_1 = Item.create(id:1, merchant_id: 1, name: "Wartooth")
    invoice_1 = @merchant.invoices.create(
      customer: customer,
      merchant: @merchant,
      status: "shipped",
      created_at: '2012-03-27 14:53:59 UTC'
    )
    invoice_2 = @merchant.invoices.create(
      customer: customer,
      merchant: @merchant,
      status: "shipped",
      created_at: '2012-04-27 14:53:59 UTC'
    )

    invoice_1.transactions.create(
      credit_card_number: '666',
      result: "success",
      created_at: '2012-03-27 14:53:59 UTC'
    )
    invoice_2.transactions.create(
      credit_card_number: '666',
      result: "success",
      created_at: '2012-04-27 14:53:59 UTC'
    )
  end

  context "/api/v1/customers/:id/invoices" do
    it "returns a collection of associated invoices" do
      get "/api/v1/customers/1/invoices"

      customer_invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer_invoices.count).to eq(2)
    end
  end

  context "/api/v1/customers/:id/transactions" do
    it "returns a collection of associated transactions" do
      get "/api/v1/customers/1/transactions"

      customer_transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer_transactions.count).to eq(2)
    end
  end
end
