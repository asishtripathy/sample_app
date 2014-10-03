class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string   :address
      t.string   :city
      t.string   :state
      t.integer  :address_type_id
      t.integer  :customer_id

      t.timestamps
    end
  end
end
