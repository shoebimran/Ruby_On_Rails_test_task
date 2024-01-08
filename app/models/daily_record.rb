# frozen_string_literal: true

# The Daliy Record class responsible for configuring the Rails.
class DailyRecord < ApplicationRecord
  after_save :update_avg_ages, if: -> { saved_change_to_male_count? || saved_change_to_female_count? }

  private

  def update_avg_ages
    male_users = User.where(gender: 'male')
    female_users = User.where(gender: 'female')

    self.male_avg_age = male_users.average(:age)
    self.female_avg_age = female_users.average(:age)
    save
  end
end
