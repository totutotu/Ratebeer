module RatingAverage
  def average_rating
    return 0 if ratings.size == 0
    return (ratings.inject(0.0) {|sum,rating| sum + rating[:score]} / ratings.size).round(2)
  end
end