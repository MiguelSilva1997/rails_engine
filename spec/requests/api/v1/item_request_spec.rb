require 'rails_helper'

describe "Items API" do

  before(:each) do
    id = 0
    merchant = Merchant.create(name: "Miguel")
    3.times do
        Item.create(
          name: "Soccer Ball",
          merchant_id: merchant.id)
      end
    Item.create(
      name: "net",
      merchant_id: merchant.id)
  end

  context "/api/v1/items"
    it "sends a list of items" do
      get '/api/v1/items'

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.first['name']).to eq("Soccer Ball")
      expect(items.last['name']).to eq("net")
      expect(items.count).to eq(4)
    end

    context "/api/v1/items/:id"
      it "sends data on an item" do
        get "/api/v1/items/#{Item.last.id}"

        item = JSON.parse(response.body)

        expect(response).to be_success
        expect(item['name']).to eq("net")
      end

    context "/items/find?name=net"
      it "sends data on a item meeting the search criteria" do
        get "/api/v1/items/find?name=net"

        item = JSON.parse(response.body)

        expect(response).to be_success
        expect(item['name']).to eq("net")
      end

    context "/items/find_all?name=Soccer%20Ball"
      it "sends data on all items meeting the search criteria" do
        get "/api/v1/items/find_all?name=Soccer%20Ball"

        items = JSON.parse(response.body)

        expect(response).to be_success
        expect(items.first['name']).to eq("Soccer Ball")
      end

    context "/items/find?id=1" do
      it "sends data on an item meeting the search criteria" do
        get "/api/v1/items/find?id=1"

        item = JSON.parse(response.body)

        expect(response).to be_success
        expect(item['name']).to eq("Soccer Ball")
      end
    end

    context "/items/find_all?id=1"
      it "sends data on all items meeting the search criteria" do
        get "/api/v1/items/find_all?id=1"

        items = JSON.parse(response.body)

        expect(response).to be_success
        expect(items.first['name']).to eq("Soccer Ball")
        expect(items.count).to eq(1)
      end

    context "/items/find?created_at=2012-03-27%2014:53:59%20UTC"
      it "sends data on an item meeting the search criteria" do
        Item.create(id: 5, name: "Cleats", created_at: '2014-04-24 14:53:59 UTC', merchant_id: Merchant.first.id)

        get "/api/v1/items/find?created_at=2014-04-24%2014:53:59%20UTC"

        item = JSON.parse(response.body)

        expect(response).to be_success
        expect(item['name']).to eq("Cleats")
      end

    context "/items/find_all?created_at=2012-03-27%2014:53:59%20UTC"
      it "sends data on an item meeting the search criteria" do
        Item.create(id: 5, name: "Cleats", created_at: '2012-03-27 14:53:59 UTC', merchant_id: Merchant.first.id)
        Item.create(id: 6, name: "Ball", created_at: '2012-03-27 14:53:59 UTC', merchant_id: Merchant.first.id)

        get "/api/v1/items/find_all?created_at=2012-03-27%2014:53:59%20UTC"

        items = JSON.parse(response.body)

        expect(response).to be_success
        expect(items.first['name']).to eq("Cleats")
        expect(items.last['name']).to eq("Ball")
      end

    context "/items/find?updated_at=2012-03-27%2014:53:59%20UTC"
      it "sends data on an item meeting the search criteria" do
        Item.create(id: 5, name: "Cleats", updated_at: '2012-03-27 14:53:59 UTC', merchant_id: Merchant.first.id)

        get "/api/v1/items/find?updated_at=2012-03-27%2014:53:59%20UTC"

        item = JSON.parse(response.body)

        expect(response).to be_success
        expect(item['name']).to eq("Cleats")
      end

    context "/items/find_all?updated_at=2012-03-27%2014:53:59%20UTC"
      it "sends data on an item meeting the search criteria" do
        Item.create(id: 5, name: "Cleats", updated_at: '2012-03-27 14:53:59 UTC', merchant_id: Merchant.first.id)
        Item.create(id: 6, name: "Ball", updated_at: '2012-03-27 14:53:59 UTC', merchant_id: Merchant.first.id)

        get "/api/v1/items/find_all?updated_at=2012-03-27%2014:53:59%20UTC"

        items = JSON.parse(response.body)

        expect(response).to be_success
        expect(items.first['name']).to eq("Cleats")
        expect(items.last['name']).to eq("Ball")
      end

    context "/items/find?description=Dangerous"
      it "sends data on an item meeting the search criteria" do
        Item.create(id: 5, name: "Cleats", description: "Dangerous", merchant_id: Merchant.first.id)

        get "/api/v1/items/find?description=Dangerous"

        item = JSON.parse(response.body)

        expect(response).to be_success
        expect(item['name']).to eq("Cleats")
      end

    context "/items/find_all?description=Dangerous"
      it "sends data on an item meeting the search criteria" do
        Item.create(id: 5, name: "Cleats", description: "Dangerous", merchant_id: Merchant.first.id)
        Item.create(id: 6, name: "Ball", description: "Dangerous", merchant_id: Merchant.first.id)

        get "/api/v1/items/find_all?description=Dangerous"

        items = JSON.parse(response.body)

        expect(response).to be_success
        expect(items.first['name']).to eq("Cleats")
        expect(items.last['name']).to eq("Ball")
      end

    context "/items/find?unit_price=10000"
      it "sends data on an item meeting the search criteria" do
        Item.create(id: 5, name: "Cleats", unit_price: 10000, merchant_id: Merchant.first.id)

        get "/api/v1/items/find?unit_price=10000"

        item = JSON.parse(response.body)

        expect(response).to be_success
        expect(item['name']).to eq("Cleats")
      end

end
