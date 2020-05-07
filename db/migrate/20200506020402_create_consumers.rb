class CreateConsumers < ActiveRecord::Migration[5.2]
  def change
    create_table :consumers do |c|
      c.string :name
      c.string :sex
      c.integer :weight
    end
  end
end
