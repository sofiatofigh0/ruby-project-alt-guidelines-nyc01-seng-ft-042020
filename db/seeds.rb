require 'pry'
require 'rest-client'
require 'json'
require 'faker'

Consumer.destroy_all
AlcoholicBeverage.destroy_all
Intake.destroy_all

100.times do 
    name = Faker::Name.first_name
    sex= Faker::Gender.binary_type
    weight= Faker::Number.between(from: 1, to: 10)
    Consumer.create(name:name,sex:sex,weight:weight)
end

ingredients=RestClient.get("https://raw.githubusercontent.com/teijo/iba-cocktails/master/recipes.json")
@ingredients_data=JSON.parse(ingredients)

@ingredients_data.collect do |details_hash|
    AlcoholicBeverage.create(cocktail_name: details_hash["name"],glass: details_hash["glass"],garnish: details_hash["garnish"],preparation: details_hash["preparation"])
end

100.times do 
    consumer_id = rand(1..100)
    alcoholic_beverage_id = rand(1..100)
    Intake.create(consumer_id: consumer_id, alcoholic_beverage_id:alcoholic_beverage_id)
end

binding.pry

puts "data loaded success"