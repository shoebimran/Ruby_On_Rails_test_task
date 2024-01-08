# frozen_string_literal: true

# Controller responsible for managing daily records.
class DailyRecordsController < ApplicationController
  def report
    @daily_records = DailyRecord.all
  end
end
