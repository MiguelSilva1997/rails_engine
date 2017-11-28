class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'citext'
    create_table :invoices do |t|
      t.citext :status
      t.references :merchant, foreign_key: true
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
