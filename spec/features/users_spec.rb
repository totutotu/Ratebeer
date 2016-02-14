require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    FactoryGirl.create :user
  end

  describe "who has signed in" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back Pekka'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"Yolo")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'

    end

    it "shows user its favorite style" do
      sign_in(username:"Pekka", password:"Foobar1")
      FactoryGirl.create(:rating, user: User.first)
      FactoryGirl.create(:rating2, beer: FactoryGirl.create(:beer2), user:User.first)

      visit user_path(User.first)
      expect(page).to have_content 'Favorite beer style: Porter'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect {
      click_button('Create User')
    }.to change{User.count}.by(1)

  end
end