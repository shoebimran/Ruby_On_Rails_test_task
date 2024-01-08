# frozen_string_literal: true

# config/initializers/redis.rb

# For a local Redis server
redis_config = {
  url: 'redis://localhost:6379/0' # Your Redis URL
  # Add other configuration options as needed
}

# Create a Redis connection
# rubocop:disable  Style/GlobalVars
$redis = Redis.new(redis_config)
# rubocop:enable  Style/GlobalVars
