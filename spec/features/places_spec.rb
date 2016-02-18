require 'rails_helper'

describe  "Places" do
  it "if one place is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    expect(page).to have_content "Oljenkorsi"

  end

  it "if three places is returned ny the API, they are all shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [ Place.new( name:"Oljenkorsi", id: 1 ), Place.new( name:"Baari", id: 2),
        Place.new( name:"Anniskelu", id: 3) ]
    )
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Baari"
    expect(page).to have_content "Anniskelu"

  end

  it "shows the correct not found message if none found" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return([])

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    expect(page).to have_content("No locations in kumpula")
  end

end