class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string  :name
      t.string  :objective
      t.string  :activities
      t.integer :pricepoint
      t.string  :email
      t.string  :startdate

      t.timestamps
    end
  end
end
