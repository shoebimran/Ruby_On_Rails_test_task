# frozen_string_literal: true

FactoryBot.define do
  factory :daily_record do
    date { Faker::Date.backward(days: 30) }
    male_count { rand(10..50) }
    female_count { rand(10..50) }
    male_avg_age { rand(20..40) }
    female_avg_age { rand(20..40) }

    # Assuming association between DailyRecord and User
    transient do
      users_count { 10 } # Number of users associated with each DailyRecord
    end

    # Create associated users with the DailyRecord
    after(:create) do |daily_record, evaluator|
      create_list(:user, evaluator.users_count, daily_record:)
    end
  end
end
