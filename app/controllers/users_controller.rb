# frozen_string_literal: true

# Controller responsible for managing user-related actions.
class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      update_daily_record_count(user)

      redirect_to users_url, notice: 'User was successfully deleted.'
    else
      redirect_to users_url, notice: 'User was not deleted.'
    end
  end

  private

  def update_daily_record_count(user)
    daily_record = DailyRecord.find_by(date: user.created_at.to_date)
    male_count, female_count = fet_count(daily_record)
    daily_record.update!(
      male_count:,
      female_count:
    )
  end

  def fet_count(daily_record)
    users = User.where('DATE(created_at) = ?', daily_record.date)

    [users.where(gender: 'male').count, users.where(gender: 'female').count]
  end
end
