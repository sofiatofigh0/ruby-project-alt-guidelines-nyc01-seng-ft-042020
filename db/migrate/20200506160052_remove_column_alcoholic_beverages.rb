class RemoveColumnAlcoholicBeverages < ActiveRecord::Migration[5.2]
  def change
    remove_column :alcoholic_beverages, :ingredients, :string
  end
end
