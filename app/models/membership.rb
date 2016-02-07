class Membership < ActiveRecord::Base
  belongs_to :beer_club
  belongs_to :user

  validates :user_id, :uniqueness =>  {:scope=>:beer_club_id}
end
