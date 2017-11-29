require 'rails_helper'

describe "Merchants API" do
    context "/merchants" do
      it "sends a list of merchants" do
          Merchant.create(name: "Miguel")
        3.times do
          Merchant.create(name: Faker::Name.unique.name )
        end

      get '/api/v1/merchants'

      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants.first['name']).to eq("Miguel")
      expect(merchants.count).to eq(4)
    end
  end
  context "/merchants/:id" do
    it "sends data on a merchant" do
      Merchant.create(name: 'Alex')
      2.times do
        Merchant.create(name: "Miguel")
      end

      get "/api/v1/merchants/#{Merchant.first.id}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant['name']).to eq("Alex")
    end
  end
  context "/merchants/find?name=Silva" do
    it "sends data on a merchant meeting the search criteria" do

      2.times do
        Merchant.create(name: "Miguel")
      end

      Merchant.create(name: "Silva")

      get "/api/v1/merchants/find?name=Silva"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant['name']).to eq("Silva")
    end
  end
  context "/merchants/find_all?name=miguel" do
    it "sends data on all merchants meeting the search criteria" do
      Merchant.create(name: "Miguel")
        3.times do
          Merchant.create(name: Faker::Name.unique.name )
        end
      get "/api/v1/merchants/find_all?name=Miguel"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant.first['name']).to eq("Miguel")
    end
  end
  context "/merchants/find?id=1" do
    it "sends data on a merchant meeting the search criteria" do

      2.times do
        Merchant.create(name: "Miguel")
      end

      Merchant.create(name: "Silva")

      get "/api/v1/merchants/find?id=1"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant['name']).to eq("Miguel")
    end
  end
  context "/merchants/find_all?id=1" do
    it "sends data on a merchant meeting the search criteria" do

      2.times do
        Merchant.create(name: "Miguel")
      end

      Merchant.create(name: "Silva")

      get "/api/v1/merchants/find_all?id=1"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant.first['name']).to eq("Miguel")
    end
  end
  context "/merchants/find?created_at=2012-03-27%2014:53:59%20UTC" do
    it "sends data on a merchant meeting the search criteria" do

      2.times do
        Merchant.create(name: "Miguel")
      end

      Merchant.create(name: "Silva", created_at: '2012-03-27 14:53:59 UTC')

      get "/api/v1/merchants/find?created_at=2012-03-27%2014:53:59%20UTC"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant['name']).to eq("Silva")
    end
  end
  context "/merchants/find_all?created_at=2012-03-27%2014:53:59%20UTC" do
    it "sends data on a merchant meeting the search criteria" do

      2.times do
        Merchant.create(name: "Miguel")
      end

      Merchant.create(name: "Silva", created_at: "2012-03-27 14:53:59 UTC")

      get "/api/v1/merchants/find_all?created_at=2012-03-27%2014:53:59%20UTC"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant.first['name']).to eq("Silva")
    end
  end
  context "/merchants/find?updated_at=2012-03-27%2014:53:59%20UTC" do
    it "sends data on a merchant meeting the search criteria" do

      2.times do
        Merchant.create(name: "Miguel")
      end

      Merchant.create(name: "Silva", updated_at: "2012-03-27 14:53:59 UTC")

      get "/api/v1/merchants/find?updated_at=2012-03-27%2014:53:59%20UTC"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant['name']).to eq("Silva")
    end
  end
  context "/merchants/find_all?updated_at=2012-03-27%2014:53:59%20UTC" do
    it "sends data on a merchant meeting the search criteria" do

      2.times do
        Merchant.create(name: "Miguel")
      end

      Merchant.create(name: "Silva", updated_at: "2012-03-27 14:53:59 UTC")

      get "/api/v1/merchants/find_all?updated_at=2012-03-27%2014:53:59%20UTC"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant.first['name']).to eq("Silva")
    end
  end
end
