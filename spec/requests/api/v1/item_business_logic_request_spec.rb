require 'rails_helper'

describe "Items Business Intelligence API" do
  before(:each) do
    @merchant = Merchant.create(id: 1, name: "Toki")
    customer = Customer.create(id: 1, first_name: "Skwisgar", last_name: "Skwigelf")
    item_1 = Item.create(id:1, merchant_id: 1, name: "Wartooth")
    item_2 = Item.create(id:2, merchant_id: 1, name: "Guitar")
    item_3 = Item.create(id:3, merchant_id: 1, name: "Metal")
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
    invoice_3 = @merchant.invoices.create(
      customer: customer,
      merchant: @merchant,
      status: "shipped",
      created_at: '2012-05-27 14:53:59 UTC'
    )

    3.times do
      invoice_1.invoice_items.create(
        item_id: item_1.id,
        quantity: 4,
        unit_price: 50
      )
      invoice_2.invoice_items.create(
        item_id: item_2.id,
        quantity: 3,
        unit_price: 50
      )
      invoice_3.invoice_items.create(
        item_id: item_3.id,
        quantity: 2,
        unit_price: 50
      )
    end
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
    invoice_3.transactions.create(
      credit_card_number: '666',
      result: "success",
      created_at: '2012-03-27 14:53:59 UTC'
    )
  end

  context "/items/most_revenue?quantity=x" do
    it "returns the top 1 items ranked by total revenue generated" do
      get "/api/v1/items/most_revenue?quantity=1"

      top_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(top_items.count).to eq(1)
      expect(top_items.first['name']).to eq("Wartooth")
    end
    it "returns the top 2 items ranked by total revenue generated" do
      get "/api/v1/items/most_revenue?quantity=2"

      top_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(top_items.count).to eq(2)
      expect(top_items.first['name']).to eq("Wartooth")
      expect(top_items.second['name']).to eq("Guitar")
    end
    it "returns the top 3 items ranked by total revenue generated" do
      get "/api/v1/items/most_revenue?quantity=3"

      top_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(top_items.count).to eq(3)
      expect(top_items.first['name']).to eq("Wartooth")
      expect(top_items.second['name']).to eq("Guitar")
      expect(top_items.third['name']).to eq("Metal")
    end
  end

  context "/api/v1/items/most_items?quantity=x" do
    it "returns the top 1 item instances ranked by total number sold" do
      get '/api/v1/items/most_items?quantity=1'

      top_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(top_items.count).to eq(1)
      expect(top_items.first['name']).to eq("Wartooth")
    end

    it "returns the top 2 item instances ranked by total number sold" do
      get '/api/v1/items/most_items?quantity=2'

      top_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(top_items.count).to eq(2)
      expect(top_items.first['name']).to eq("Wartooth")
      expect(top_items.last['name']).to eq("Guitar")
    end

    it "returns the top 3 item instances ranked by total number sold" do
      get '/api/v1/items/most_items?quantity=3'

      top_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(top_items.count).to eq(3)
      expect(top_items.first['name']).to eq("Wartooth")
      expect(top_items.second['name']).to eq("Guitar")
      expect(top_items.last['name']).to eq("Metal")
    end
  end

  context "/api/v1/items/:id/best_day" do
    it "returns the date with the most sales for the given item using the invoice date.
        If there are multiple days with equal number of sales,
        return the most recent day." do
        get "/api/v1/items/1/best_day"

        best_day = JSON.parse(response.body)

        expect(response).to be_success
        expect(best_day['best_day']).to eq("2012-03-27T14:53:59.000Z")
    end
  end

end
