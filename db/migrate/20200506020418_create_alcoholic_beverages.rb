class CreateAlcoholicBeverages < ActiveRecord::Migration[5.2]
  def change
    create_table :alcoholic_beverages do |a|
      a.string :cocktail_name
    end
  end
end
