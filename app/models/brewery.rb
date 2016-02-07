class Brewery < ActiveRecord::Base
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers
  include RatingAverage
  validates :name, length: { minimum:  1 }
  validates :year, numericality: {only_integer:  true,
                                  greater_than_or_equal_to: 1042}
  validate :validate_year

  def validate_year
    errors.add :year, " can't be in the future" if year > Time.now.year.to_i
  end



  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end
end
