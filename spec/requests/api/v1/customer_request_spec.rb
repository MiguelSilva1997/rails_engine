require "rails_helper"

describe "Customer Endpoint" do
  before(:each) do
    Customer.create(
      first_name: "Miguel",
      last_name: "Silva",
      created_at: '2012-03-27 14:54:09 UTC',
      updated_at: '2012-03-27 14:54:09 UTC'
       )
    3.times do
     Customer.create(
       first_name: Faker::Name.unique.first_name,
       last_name: Faker::Name.unique.last_name,
       created_at: '2012-03-27 14:54:09 UTC',
       updated_at: '2012-03-27 14:54:09 UTC'
        )
    end
  end

  describe "when visit /customers" do
    it "it returns success" do
      get '/api/v1/customers'

      expect(response).to be_success
    end

    it "returns a list of all the customers" do
      get '/api/v1/customers'

      customer = JSON.parse(response.body)

      expect(customer.first['first_name']).to eq("Miguel")
      expect(customer.count).to eq(4)
    end

    context "/customers/:id" do
      it "sends a customer" do

      get "/api/v1/customers/#{Customer.first.id}"

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers['first_name']).to eq("Miguel")
      end
    end
    context "/customers/find?id=1" do
      it "sends data on all items meeting the search criteria" do
        get "/api/v1/customers/find?id=#{Customer.first.id}"

        customers = JSON.parse(response.body)

        expect(response).to be_success
        expect(customers['first_name']).to eq("Miguel")
      end
    end
    context "/customers/find?first_name=TIMMY" do
      it "sends data on all items meeting the search criteria" do
        get "/api/v1/customers/find?first_name=#{Customer.first.first_name}"

        customers = JSON.parse(response.body)

        expect(response).to be_success
        expect(customers['first_name']).to eq("Miguel")
      end
    end
    context "/customers/find?last_name=jONES" do
      it "sends data on all items meeting the search criteria" do
        get "/api/v1/customers/find?last_name=#{Customer.first.last_name}"

        customers = JSON.parse(response.body)

        expect(response).to be_success
        expect(customers['last_name']).to eq("Silva")
      end
    end

    context "/customers/find?created_at=2012-03-27%2014:54:09%20UTC" do
      it "sends data on all items meeting the search criteria" do
        get "/api/v1/customers/find?created_at=2012-03-27%2014:54:09%20UTC"

        customers = JSON.parse(response.body)

        expect(response).to be_success
        expect(customers['first_name']).to eq("Miguel")
      end
    end

    context "/customers/find?updated_at=2012-03-27%2014:54:09%20UTC" do
      it "sends data on all items meeting the search criteria" do
        get "/api/v1/customers/find?updated_at=2012-03-27%2014:54:09%20UTC"

        customers = JSON.parse(response.body)

        expect(response).to be_success
        expect(customers['first_name']).to eq("Miguel")
      end
    end

    context "/customers/find_all?created_at=2012-03-27%2014:54:09%20UTC" do
      it "sends data on all items meeting the search criteria" do
        get "/api/v1/customers/find_all?created_at=2012-03-27%2014:54:09%20UTC"

        customers = JSON.parse(response.body)

        expect(response).to be_success
        expect(customers.first['first_name']).to eq("Miguel")
      end
    end

    context "/customers/find_all?updated_at=2012-03-27%2014:54:09%20UTC" do
      it "sends data on all items meeting the search criteria" do
        get "/api/v1/customers/find_all?updated_at=2012-03-27%2014:54:09%20UTC"

        customers = JSON.parse(response.body)

        expect(response).to be_success
        expect(customers.first['first_name']).to eq("Miguel")
      end
    end

    context "/customers/find_all?id=1" do
      it "sends data on all items meeting the search criteria" do
        get "/api/v1/customers/find_all?id=#{Customer.first.id}"

        customers = JSON.parse(response.body)

        expect(response).to be_success
        expect(customers.first['first_name']).to eq("Miguel")
      end
    end
    context "/customers/find_all?first_name=TIMMY" do
      it "sends data on all items meeting the search criteria" do
        get "/api/v1/customers/find_all?first_name=#{Customer.first.first_name}"

        customers = JSON.parse(response.body)

        expect(response).to be_success
        expect(customers.first['first_name']).to eq("Miguel")
      end
    end
    context "/customers/find_all?last_name=jONES" do
      it "sends data on all items meeting the search criteria" do
        get "/api/v1/customers/find_all?last_name=#{Customer.first.last_name}"

        customers = JSON.parse(response.body)

        expect(response).to be_success
        expect(customers.first['last_name']).to eq("Silva")
      end
    end
  end
end
