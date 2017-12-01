require 'rails_helper'

describe "Invoices Relationships API" do
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
  end
  context "/api/v1/invoice_items/:id/invoice" do
    it " returns a collection of associated invoice" do

      get "/api/v1/invoice_items/#{InvoiceItem.first.id}/invoice"

      item_invoice_invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(item_invoice_invoice["id"]).to eq(InvoiceItem.first.invoice_id)
    end
  end
  context "/api/v1/invoice_items/:id/item" do
    it " returns a collection of associated item" do

      get "/api/v1/invoice_items/#{InvoiceItem.first.id}/item"

      item_invoice_invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(item_invoice_invoice["id"]).to eq(InvoiceItem.first.item_id)
    end
  end
end
