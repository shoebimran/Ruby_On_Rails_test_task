# frozen_string_literal: true

# spec/controllers/daily_records_controller_spec.rb

require 'rails_helper'

RSpec.describe DailyRecordsController, type: :controller do
  let(:daily_record) { create(:daily_record, date: Date.today) }
  let(:male_user) { create(:user, gender: 'male', age: 30, daily_record:) }
  let(:female_user) { create(:user, gender: 'female', age: 25, daily_record:) }

  describe '#report' do
    before do
      get :report
    end
  end
end
