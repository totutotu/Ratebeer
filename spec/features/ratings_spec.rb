require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "lists existing ratings and their number" do
    FactoryGirl.create(:rating, user: user)
    FactoryGirl.create(:rating2, beer: FactoryGirl.create(:beer2), user:user)

    visit ratings_path

    expect(Rating.count).to be(2)
    expect(page).to have_content("anonymous")
    expect(page).to have_content("anonymous2")
  end

  it "shows user only his own ratings" do
    FactoryGirl.create(:rating, user: user)
    FactoryGirl.create(:rating2, beer: FactoryGirl.create(:beer2), user:user)
    FactoryGirl.create(:rating2, beer: FactoryGirl.create(:beer3), user: FactoryGirl.create(:user2))

    visit user_path(user)

    expect(page).to have_content("anonymous")
    expect(page).to have_content("anonymous2")
    expect(page).not_to have_content("anonymousr")
  end

  it "removes users rating" do
    FactoryGirl.create(:rating, user: user)
    visit user_path(user)
    expect{
      page.all('a', text:'Destroy')[0].click
    }.to change{Rating.count}.by(-1)

    expect(page).to have_content("Rating was successfully destroyed.")
    expect(page).not_to have_content("anonymous")
  end
end