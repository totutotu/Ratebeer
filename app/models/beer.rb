class Beer < ActiveRecord::Base
  belongs_to :brewery
  belongs_to :style

  has_many :ratings, dependent: :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user
  include RatingAverage

  validates :name, length: {minimum: 1}


  def self.top(n)
    sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating||0) }
    return sorted_by_rating_in_desc_order.take(n);
  end

  def to_s
    return "#{name} (#{brewery.name})"
  end

end
