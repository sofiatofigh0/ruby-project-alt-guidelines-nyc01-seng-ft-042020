class Consumer < ActiveRecord::Base

    has_many :intakes
    has_many :alcoholic_beverages, through: :intakes

end