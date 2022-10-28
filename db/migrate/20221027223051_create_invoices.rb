class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.string :stripe_id
      t.string :stripe_customer_id

      t.date :due_date
      t.timestamp :invoiced_at

      t.timestamps
    end
  end
end
