class Recipe < ActiveRecord::Base
  has_many :kitchens
  has_many :tags, through: :kitchens
end
