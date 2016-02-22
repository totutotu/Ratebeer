class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :name
      t.text :description
      t.timestamps null: false
    end

    Style.create name:"Lager", description:"kaunista olutta"
    Style.create name:"Weizen", description:"olutta"
    Style.create name:"Pale ale", description:"rumaa olutta"
    Style.create name:"IPA", description:"olutta"
    Style.create name:"Porter", description:"dfas olutta"
    Style.create name:"lowalcohol", description:"d olutta"
    Style.create name:"Laimuri", description:"kaunisdta olutta"
  end
end
