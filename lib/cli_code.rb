require 'pry'
require 'rest-client'
require 'json'

class CLI

def run
  puts "Hey! Looks like you're in need of a drink ;)"
  sleep(3)
  puts "I'll be your virtual bartender,which is all the same as being in a bar,except you'll be making the drinks this time."
  sleep(3)
  puts "I'll still be making sure you are never TOO sober and just the right amount of drunk, by keeping track of your drinks."
  sleep(3)
  puts "Let me grab some information before the belligerency commences!" 
  sleep(3)
end

def request_name
  puts "Please enter your name:"
  @name=gets.chomp.strip.titleize
end

def request_age
  puts "Please enter your age:"
  @age=gets.chomp.strip.to_i
end

def age_valid?
  unless @age.between?(21,120)
    puts "Sorry! This program is only availble to those 21 and over. Goodbye!"
    abort
  end
end


def request_sex
  puts "Please enter your sex (Male or Female):"
  @sex=gets.chomp.strip
end

def check_sex
  if @sex== "Male" || @sex=="male" || @sex== "female" || @sex=="Female" 
    puts "Okay one more request I promise!"
  else
    until @sex== "Male" || @sex=="male" || @sex== "female" || @sex=="Female"
      loop do
    puts "Sorry, sex must be either male or female, please enter again:"
    @sex=gets.chomp.strip
      break
      end
      puts "Okay one more request I promise!"
    end
  end
end

def request_weight
  puts "Please enter your weight in pounds:"
  @weight=gets.to_i
end

def check_weight
  until @weight.between?(80,800)
    puts "Please enter accurate weight!"
    @weight=gets.to_i
  end
end

def create_user
  @new_user=Consumer.create(name: @name,sex: @sex, weight: @weight)
  puts "Welcome #{@new_user.name}!"
end

def attn_menu
  puts "Here is a huge menu of drinks. Take your time and choose whatever tickles your fancy:"
end

def display
  menu_list=AlcoholicBeverage.pluck(:cocktail_name)
  sleep(0.4)
  puts menu_list
 sleep(2)
end


def ingredients_and_amounts
  ingredients=RestClient.get("https://raw.githubusercontent.com/teijo/iba-cocktails/master/recipes.json")
  ingredients_data=JSON.parse(ingredients)
     
  ingredients_data.collect do |details_hash|
    if details_hash["name"] == @chosen_cocktail
      details_hash["ingredients"].collect do |ingredients_hash|
      @ingredients=ingredients_hash["ingredient"]
      puts "#{@ingredients.split(",")}"
      end
    end
  end
  ingredients_data.collect do |details_hash|
    if details_hash["name"] == @chosen_cocktail
      details_hash["ingredients"].collect do |ingredients_hash|
      @amounts=ingredients_hash["amount"]
      puts "#{@amounts}"
      end
    end
  end
end

def drink_valid?

    puts "#{@chosen_cocktail},mmm good choice!"
    puts "Now that you've chosen your cocktail, I'll provide you with details on the necessary ingredients,glass and garnishes!"
    sleep(2)
    glass_type = AlcoholicBeverage.where(cocktail_name: @chosen_cocktail).map(&:glass)
    puts "Required : #{glass_type.join.titleize} glass."
    sleep(2)

    garnish = AlcoholicBeverage.where(cocktail_name: @chosen_cocktail).map(&:garnish)
     if garnish.join.titleize == ""
      puts "No garnish needed!"
     else
      puts "Required garnish: #{garnish.join.titleize}"
    end
    sleep(2)

    preparation = AlcoholicBeverage.where(cocktail_name: @chosen_cocktail).pluck("preparation")
     puts "To prepare : #{preparation.join}"

     sleep(2)
     puts "The ingredients and amounts,respectively,are:"
     ingredients_and_amounts

     sleep(1)
    puts "Would you like another drink (yes/no)?"
  end

def ask
 @consumed_drinks=[]
  until @consumed_drinks.count >= 15
    sleep(1)
    puts "So, what's your poison?"
  @chosen_cocktail=gets.chomp.titleize
    until AlcoholicBeverage.find_by(cocktail_name: @chosen_cocktail)
        puts "Sorry please choose something on the list!"
       @chosen_cocktail=gets.chomp.titleize
   end
   drink_valid?
  new_drink=gets.chomp.strip.titleize
      if new_drink == "Yes" || new_drink == "yes"
        display
      else
        puts "Done for the night."
        @consumed_drinks << @chosen_cocktail
        puts "Here's a list of drinks you've had thus far: #{@consumed_drinks.inspect}"
      break 
  end
    @consumed_drinks << @chosen_cocktail
    puts "Here's a list of drinks you've had thus far: #{@consumed_drinks.inspect}"
    if @consumed_drinks.count >= 7
      @new_user.update(name: "I cnat memberrrr ma name no more")
       puts @new_user.name
     end
  end
end

def update_and_delete
  if @consumed_drinks.count > 12
     @new_user.destroy
      puts "I am literally destroyed."
  end
end

def execute_all
  run
  request_name
  request_age
  age_valid?
  request_sex
  check_sex
  request_weight
  check_weight
  create_user
  sleep(1)
  attn_menu
  sleep(3)
  display
  sleep (1)
  ask
end

end










# def BAC

#  puts "How long have you been drinking for (hours)? "

#   time_spent_drinking=gets.chomp.strip

#   blood_alc_level = (((a*n)*5.14)/w*r)-(0.015*time_spent_drinking)

# if @new_user.sex== "Male" || @new_user.sex=="male"
#   r = 0.73
# else
#   r = 0.66
# end

# w = @new_user.weight

# def abv

# abv=RestClient.get("https://raw.githubusercontent.com/sofiatofigh0/iba-cocktails/master/ingredients.json")
# abv_data=JSON.parse(abv)

# abv_data.collect do |x,y|
#     y["abv"]
# end
# end
