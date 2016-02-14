FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :user2, class: User do
    username "kamala"
    password "K44k44"
    password_confirmation "K44k44"

  end

  factory :rating do
    beer
    score 10
  end

  factory :rating2, class: Rating do
    score 20
  end
  factory :rating3, class: Rating do
    score 50
  end


  factory :brewery do
    name "anonymous"
    year 1900
  end

  factory :beer do
    name "anonymous"
    brewery
    style "Lager"
  end


  factory :beer2, class: Beer do
    name "anonymous2"
    brewery
    style "Porter"
  end

  factory :beer3, class: Beer do
    name "anonymousr"
    brewery
    style "IPA"
  end
end