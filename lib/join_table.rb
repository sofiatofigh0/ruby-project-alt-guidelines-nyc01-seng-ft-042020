class Intake < ActiveRecord::Base

    belongs_to :consumer
    belongs_to :alcoholic_beverage

end
