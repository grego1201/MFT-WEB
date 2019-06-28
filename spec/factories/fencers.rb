FactoryGirl.define do
  factory :fencer do
    name { "Fencer1" }
    grip { rand(2) }
    height { rand(2) }
    age { rand(10..99) }
    intimidated { [true, false].sample }
  end
end
