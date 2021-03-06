require 'rails_helper'


RSpec.describe Beer, type: :model do
  let!(:user) { FactoryGirl.create :user }

  let!(:style) { FactoryGirl.create :style}


  it "is saved" do
    beer = Beer.create name:"Kalja"

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved without a name" do
    beer = Beer.create style_id: 1

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.create name:"Kalja"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end


end
