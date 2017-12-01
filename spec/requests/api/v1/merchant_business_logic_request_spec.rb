require 'rails_helper'

describe "Merchants Business Intelligence API" do
  before(:each) do
    @merchant = Merchant.create(id: 1, name: "Timmy")
    @merchant_2 = Merchant.create(id: 2, name: "Johnny")
    customer = Customer.create(id: 1, first_name: "Pauly", last_name: "Shore")
    customer2 = Customer.create(id: 2, first_name: "Jazzy", last_name: "Jeff")
    item = Item.create(id: 1, merchant_id: 1, name: 'Sofa')

    merchant_2_invoice = @merchant_2.invoices.create(
      customer: customer,
      merchant: @merchant_2,
      status: "shipped",
      created_at: '2012-02-27 14:53:59 UTC'
    )
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
    one_month_later_good_invoice = @merchant.invoices.create(
      customer: customer,
      merchant: @merchant,
      status: "shipped",
      created_at: '2012-03-27 14:53:59 UTC'
      )
    another_invoice = @merchant.invoices.create(
      customer: customer2,
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
      one_month_later_good_invoice.invoice_items.create(
        item_id: item.id,
        quantity: 4,
        unit_price: 75,
        created_at: '2012-03-27 14:53:59 UTC'
      )
      another_invoice.invoice_items.create(
        item_id: item.id,
        quantity: 4,
        unit_price: 75,
        created_at: '2012-03-27 14:53:59 UTC'
      )
      merchant_2_invoice.invoice_items.create(
        item_id: item.id,
        quantity: 4,
        unit_price: 75,
        created_at: '2012-03-27 14:53:59 UTC'
      )
    end
    good_invoice.transactions.create(
      credit_card_number: '666',
      result: "success",
      created_at: '2012-03-27 14:53:59 UTC'
    )
    one_month_later_good_invoice.transactions.create(
      credit_card_number: '666',
      result: "success",
      created_at: '2012-04-27 14:53:59 UTC'
    )
    bad_invoice.transactions.create(
      credit_card_number: '666',
      result: "failed",
      created_at: '2012-03-27 14:53:59 UTC'
    )
    merchant_2_invoice.transactions.create(
      credit_card_number: '666',
      result: "success",
      created_at: '2012-03-27 14:53:59 UTC'
    )
  end
  context "/merchants/:id/revenue" do
    it "returns the total revenue for that merchant across successful transactions" do

      get "/api/v1/merchants/#{@merchant.id}/revenue"

      merchant_revenue = JSON.parse(response.body)
      expect(response).to be_success
      expect(merchant_revenue["revenue"]).to eq('12.00')
    end
  end
  context "/merchants/:id/revenue?date=2012-03-27%2014:53:59%20UTC" do
    it "returns the total revenue for that merchant across successful transactions" do

      date = "2012-03-27%2014:53:59%20UTC"
      get "/api/v1/merchants/#{@merchant.id}/revenue?date=#{date}"

      merchant_revenue = JSON.parse(response.body)
      expect(response).to be_success
      expect(merchant_revenue["revenue"]).to eq("9.00")
    end
  end

  context "/merchants/revenue?date=2012-03-27%2014:53:59%20UTC" do
    it "returns the total revenue for all merchants across successful transactions" do

      date = "2012-03-27%2014:53:59%20UTC"
      get "/api/v1/merchants/revenue?date=#{date}"

      merchant_revenue = JSON.parse(response.body)
      expect(response).to be_success
      expect(merchant_revenue["total_revenue"]).to eq("9.00")
    end
  end

  context "/merchants/:id/favorite_customer" do
    it "Returns the customer who has conducted the most total number of successful transactions." do
      get "/api/v1/merchants/#{@merchant.id}/favorite_customer"

      merchant_favorite = JSON.parse(response.body)
      expect(response).to be_success
      expect(merchant_favorite["id"]).to eq(1)
    end
  end

  context "/api/v1/merchants/most_items?quantity=x" do
    it "returns the top 1 merchants ranked by total number of items sold" do
      get "/api/v1/merchants/most_items?quantity=1"

      top_merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(top_merchants.count).to eq(1)
      expect(top_merchants.first['name']).to eq("Timmy")
    end

    it "returns the top 2 merchants ranked by total number of items sold" do
      get "/api/v1/merchants/most_items?quantity=2"

      top_merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(top_merchants.count).to eq(2)
      expect(top_merchants.first['name']).to eq("Timmy")
    end
  end
end
