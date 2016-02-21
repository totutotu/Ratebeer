class Beer < ActiveRecord::Base
  belongs_to :brewery
  belongs_to :style

  has_many :ratings, dependent: :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user
  include RatingAverage

  validates :name, length: {minimum: 1}

  def to_s
    return "#{name} (#{brewery.name})"
  end

end
