class Style < ActiveRecord::Base
  has_many :beers
  validates :name, length: { minimum:  1 }, uniqueness: true
end
