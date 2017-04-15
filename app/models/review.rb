class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  validates_presence_of :description
  validates_presence_of :rating
end
