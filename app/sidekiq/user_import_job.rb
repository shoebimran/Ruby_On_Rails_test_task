# frozen_string_literal: true

# Handles the background job for importing users using Sidekiq.
class UserImportJob
  include Sidekiq::Job

  def perform
    users = fetch_users

    users.each do |user_data|
      user = find_or_initialize_user(user_data)
      update_user_attributes(user, user_data)
    end

    update_gender_counts(users)
  end

  private

  def fetch_users
    response = HTTParty.get('https://randomuser.me/api/?results=20')
    JSON.parse(response.body)['results']
  end

  def find_or_initialize_user(user_data)
    User.find_or_initialize_by(uuid: user_data['login']['uuid'])
  end

  def update_user_attributes(user, user_data)
    user.assign_attributes(
      gender: user_data['gender'],
      name: user_data['name'],
      location: user_data['location'],
      age: user_data['dob']['age']
    )
    user.save
  end

  def update_gender_counts(users)
    gender_count = calculate_gender_counts(users)
    update_redis_with_counts(gender_count)
  end

  # rubocop:disable  Metrics/MethodLength
  def calculate_gender_counts(users)
    male_count = users.count { |user| user['gender'] == 'male' }
    female_count = users.count { |user| user['gender'] == 'female' }
    # rubocop:disable Style/GlobalVars
    existing_data = $redis.get('gender_count')
    # rubocop:enable Style/GlobalVars
    if existing_data.nil?
      { male_count:, female_count: }
    else
      existing_count = JSON.parse(existing_data)
      {
        male_count: male_count + existing_count['male_count'].to_i,
        female_count: female_count + existing_count['female_count'].to_i
      }
    end
  end

  # rubocop:enable  Metrics/MethodLength
  def update_redis_with_counts(gender_count)
    # rubocop:disable Style/GlobalVars
    $redis.set('gender_count', gender_count.to_json)
    # rubocop:enable Style/GlobalVars
  end
end
