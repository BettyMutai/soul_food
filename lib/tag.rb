class Tag < ActiveRecord::Base
  has_many :kitchens
  has_many :recipes, through: :kitchens
end
