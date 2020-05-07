class CreateIntakes < ActiveRecord::Migration[5.2]
  def change
    create_table :intakes do |i|
      i.integer :consumer_id
      i.integer :alcoholic_beverage_id
  end
end
end
