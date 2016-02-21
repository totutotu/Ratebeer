require 'rails_helper'

include Helpers

describe "Beer" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:user) { FactoryGirl.create :user }



  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "is added to database when name is not empty" do
    visit new_beer_path

    fill_in('beer_name', with:"Uusikalija")

    expect{
      click_button 'Create Beer'
    }.to change{Beer.count}.from(0).to(1)
  end

  it "is not saved without a name" do
    visit new_beer_path
    fill_in('beer_name', with:"")

    click_button('Create Beer')
    expect(Beer.count).to be(0)
    expect(page).to have_content "Name is too short (minimum is 1 character)"

  end
end