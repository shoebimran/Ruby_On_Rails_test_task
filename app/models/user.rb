# frozen_string_literal: true

# Handles the background job related to daily records using Sidekiq.
class User < ApplicationRecord
  self.primary_key = 'uuid'
  validates :uuid, presence: true, uniqueness: true
  validates :gender, presence: true
  validates :name, presence: true
  validates :age, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def full_name
    "#{name['title']}. #{name['first']} #{name['last']}"
  end
end
