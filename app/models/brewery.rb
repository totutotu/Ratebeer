class Brewery < ActiveRecord::Base
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  include RatingAverage

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }

  validates :name, length: { minimum:  1 }
  validates :year, numericality: {only_integer:  true,
                                  greater_than_or_equal_to: 1042}
  validate :validate_year

  def validate_year
    errors.add :year, " can't be in the future" if year > Time.now.year.to_i
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating||0) }
    return sorted_by_rating_in_desc_order.take(n);
  end



  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end
end
