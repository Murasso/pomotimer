class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:week,:month,:year]
  def index
    @users=User.all
    
  end

  def week
    @user = User.find(params[:id])
    study_records = @user.study_records
    @data=study_records.group_by_day(:created_at, last: 7, current: true).sum('study_records.num_of_session')
  end
  
  def month
    @user = User.find(params[:id])
    study_records = @user.study_records
    @data=study_records.group_by_day(:created_at, last: 30, current: true).sum('study_records.num_of_session')
  end
  
  def year
    @user = User.find(params[:id])
    study_records = @user.study_records
    @data=study_records.group_by_month(:created_at, last: 12, current: true).sum('study_records.num_of_session')
  end
  
  
  private
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to week_user_path(current_user.id)
    end
  end
  
end