class User < ActiveRecord::Base
  include RatingAverage

  validates :username, uniqueness: true,
            length:  {minimum: 3, maximum: 15}
  validates :password, length: {minimun: 5, maximum: 15}
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
end
