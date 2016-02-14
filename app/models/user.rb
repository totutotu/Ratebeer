class User < ActiveRecord::Base
  include RatingAverage

  validates :username, uniqueness: true,
            length:  {minimum: 3, maximum: 15}
  validates :password, length: {minimum: 5, maximum: 15}
  validate :password_complexity

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def password_complexity
    if password.present? and not password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])./)
      errors.add :password, "must include at least one lowercase letter, uppercase letter, and one digit"
    end

  end

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style

    # tämä koodinpätkä on kaunein mitä tulet koskaan elämässäsi näkemään

    return nil if ratings.empty?
    return ratings.first.beer.style if ratings.count == 1

    weizens = ratings.find_all {|r| r.beer.style == "Weizen"}
    lagers= ratings.find_all {|r| r.beer.style == "Lager"}
    paleales = ratings.find_all {|r| r.beer.style == "Pale Ale"}
    ipas = ratings.find_all {|r| r.beer.style == "IPA"}
    porters = ratings.find_all {|r| r.beer.style == "Porter"}

    beers = ["Weizen", "Lager", "Pale ale", "IPA", "Porter"]
    values = [
        (weizens.inject(0.0) {|sum,rating| sum + rating[:score]} / (weizens.size + 0.00000001)).round(2),
        (lagers.inject(0.0) {|sum,rating| sum + rating[:score]} / (lagers.size + 0.0000001)).round(2),
        (paleales.inject(0.0) {|sum,rating| sum + rating[:score]} / (paleales.size  + 0.00000001)).round(2),
        (ipas.inject(0.0) {|sum,rating| sum + rating[:score]} / (ipas.size  + 0.00000001)).round(2),
        (porters.inject(0.0) {|sum,rating| sum + rating[:score]} / (porters.size  + 0.00000001)).round(2),
    ]

    return beers[values.index(values.max)]

  end
end
