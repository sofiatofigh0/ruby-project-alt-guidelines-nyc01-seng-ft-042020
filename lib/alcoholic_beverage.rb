class AlcoholicBeverage < ActiveRecord::Base
    has_many :intakes
    has_many :consumers, through: :intakes

end