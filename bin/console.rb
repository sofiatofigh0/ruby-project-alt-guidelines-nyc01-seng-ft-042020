require 'pry'
require 'rest-client'
require 'json'

abv=RestClient.get("https://raw.githubusercontent.com/sofiatofigh0/iba-cocktails/master/ingredients.json")
abv_data=JSON.parse(abv)



binding.pry