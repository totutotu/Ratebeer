module RatingAverage
  def average_rating

    return (ratings.inject(0.0) {|sum,rating| sum + rating[:score]} / ratings.size).round(2)
  end
end