require 'factory_girl'

FactoryGirl.define do

  factory :profile do |p|
    p.name 'Sasha'
  end

  factory :user do |u|
    u.email 'email@example.com'
    u.password 'password'
    u.profile { |p| p.association(:profile) }
  end

  factory :another_profile do |p|
    p.name 'Misha'
  end

  factory :another_user do |u|
    u.email 'another_@example.com'
    u.password 'another_password'
    u.profile { |p| p.association(:another_profile) }
  end

end
