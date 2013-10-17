# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :picture do
    title "MyString"
    added "2013-10-17"
    image "MyString"
    private false
  end
end
