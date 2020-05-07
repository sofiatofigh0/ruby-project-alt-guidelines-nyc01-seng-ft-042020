class AddColumnsToAlcoholicBeverage < ActiveRecord::Migration[5.2]
  def change
    add_column :alcoholic_beverages, :glass, :string
    add_column :alcoholic_beverages, :ingredients, :string
    add_column :alcoholic_beverages, :garnish, :string, default: "None"
    add_column :alcoholic_beverages, :preparation, :string
  end
end
