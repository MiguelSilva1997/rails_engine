require 'rails_helper'

describe "Invoices API" do
  before(:each) do
    customer = Customer.create(first_name: 'Miguel', last_name: 'Silva')
    merchant = Merchant.create(name: "Breanna")
    3.times do
        Invoice.create(
          customer: customer,
          merchant: merchant,
          status: 'complete',
          created_at: '2012-03-27 14:53:59 UTC',
          updated_at: '2012-03-27 14:53:59 UTC'
        )
    end
  end
    context "/invoices" do
      it "sends a list of invoices" do
      get '/api/v1/invoices'

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.first['status']).to eq("complete")
      expect(invoices.count).to eq(3)
    end
  end
  context "/invoices/:id" do
    it "sends a single invoice" do

    get "/api/v1/invoices/#{Invoice.first.id}"

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices['status']).to eq("complete")
    expect(invoices['id']).to eq(1)
    end
  context "/invoices/find?id=1" do
      it "sends a single invoice" do

      get "/api/v1/invoices/find?id=#{Invoice.first.id}"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices['status']).to eq("complete")
      expect(invoices['id']).to eq(1)
      end
    end
  context "/invoices/find?customer_id=1" do
    it "sends a single invoice" do
      merchant = Merchant.create(name: "Breanna")
      customer = Customer.create(first_name: "Miguel", last_name: "Silva")
      Invoice.create(
        customer: customer,
        merchant: merchant,
        status: 'complete',
        created_at: '2012-03-27 14:53:59 UTC',
        updated_at: '2012-03-27 14:53:59 UTC'
      )

      get "/api/v1/invoices/find?customer_id=#{customer.id}"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices['customer_id']).to eq(customer.id)
      end
    end
  context "/invoices/find?merchant_id=1" do
      it "sends a single invoice" do
      merchant = Merchant.create(name: "Breanna")
      customer = Customer.create(first_name: "Miguel", last_name: "Silva")
      Invoice.create(
        customer: customer,
        merchant: merchant,
        status: 'complete',
        created_at: '2012-03-27 14:53:59 UTC',
        updated_at: '2012-03-27 14:53:59 UTC'
      )

      get "/api/v1/invoices/find?merchant_id=#{merchant.id}"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices['merchant_id']).to eq(merchant.id)
      expect(invoices['id']).to eq(4)
      end
    end
  context "/invoices/find?status=complete" do
      it "sends a single invoice" do

      get "/api/v1/invoices/find?status=complete"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices['status']).to eq('complete')
      expect(invoices['id']).to eq(1)
      end
    end
  context "/invoicess/find?created_at=2012-03-27%2014:53:59%20UTC" do
      it "sends a single invoice" do

      get "/api/v1/invoices/find?created_at=2012-03-27%2014:53:59%20UTC"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices['id']).to eq(1)
      end
    end
  context "/invoicess/find?updated_at=2012-03-27%2014:53:59%20UTC" do
      it "sends a single invoice" do

      get "/api/v1/invoices/find?updated_at=2012-03-27%2014:53:59%20UTC"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices['id']).to eq(1)
      end
    end
  context "/invoices/find_all?id=1" do
      it "sends all invoices with that id" do

      get "/api/v1/invoices/find_all?id=#{Invoice.first.id}"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.first['status']).to eq("complete")
      expect(invoices.first['id']).to eq(1)
      end
    end
  context "/invoices/find_all?status=complete" do
      it "sends all invoices that are complete" do

      get "/api/v1/invoices/find_all?status=complete"

      invoices = JSON.parse(response.body)

      expect(response).to be_success

      expect(invoices.first['status']).to eq('complete')
      expect(invoices.second['status']).to eq('complete')
      end
    end
  context "/invoicess/find_all?created_at=2012-03-27%2014:53:59%20UTC" do
      it "sends all invoices that were created on specified date" do

      get "/api/v1/invoices/find_all?created_at=2012-03-27%2014:53:59%20UTC"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(3)
      end
    end
  context "/invoicess/find_all?updated_at=2012-03-27%2014:53:59%20UTC" do
      it "sends all invoices that were updated on specified date" do

      get "/api/v1/invoices/find_all?updated_at=2012-03-27%2014:53:59%20UTC"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(3)
      end
    end
  end
end
