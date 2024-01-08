# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    uuid { SecureRandom.uuid }
    name { { 'last' => Faker::Name.name, 'first' => Faker::Name.name, 'title' => Faker::Name.name } }
    gender { 'female' }
    location do
      {
        'city' => 'Atliaca',
        'state' => 'Tamaulipas',
        'street' => { 'name' => 'Continuación Cedillo', 'number' => 6964 },
        'country' => 'Mexico',
        'postcode' => 44_742,
        'timezone' => { 'offset' => '+5:00', 'description' => 'Ekaterinburg, Islamabad, Karachi, Tashkent' },
        'coordinates' => { 'latitude' => '16.1322', 'longitude' => '-125.3304' }
      }
    end
    age { 38 }
  end
end
