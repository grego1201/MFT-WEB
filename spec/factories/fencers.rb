FactoryGirl.define do
  factory :fencer do
    name { 'Fencer1' }
    grip { rand(2) }
    height { rand(2) }
    age { rand(10..99) }
    intimidated { [true, false].sample }
    handness { rand(2) }
    weapon { rand(3) }
    ranking { rand(99999999) }
  end
end
