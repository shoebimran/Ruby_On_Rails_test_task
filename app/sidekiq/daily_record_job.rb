# frozen_string_literal: true

# Handles the background job related to daily records using Sidekiq.
class DailyRecordJob
  include Sidekiq::Job
  # rubocop:disable  Metrics/MethodLength
  def perform
    male_count, female_count = retrieve_gender_counts_from_redis
    date = Date.today
    male_avg_age, female_avg_age = update_average_ages
    DailyRecord.create!(
      male_count:,
      female_count:,
      male_avg_age:,
      female_avg_age:,
      date:
    )
    # rubocop:disable Style/GlobalVars
    $redis.del('gender_count')
    # rubocop:enable Style/GlobalVars
  end
  # rubocop:enable  Metrics/MethodLength

  private

  def retrieve_gender_counts_from_redis
    # rubocop:disable Style/GlobalVars
    gender_data = $redis.get('gender_count')
    # rubocop:enable Style/GlobalVars
    return [0, 0] if gender_data.nil?

    counts = JSON.parse(gender_data)
    [counts['male_count'].to_i, counts['female_count'].to_i]
  end

  def update_average_ages
    [calculate_average_age('male'), calculate_average_age('female')]
  end

  def calculate_average_age(gender)
    total_age = User.where(gender:).average(:age)
    total_age.nil? ? 0 : total_age.to_i
  end
end
