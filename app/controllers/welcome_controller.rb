class WelcomeController < ApplicationController

  before_filter :set_defaults

  def index
    @users = Harvest::Application::CONFIG['user_emails'].to_s.gsub(' ', '').split(',').inject({}) { |h, elem| h[elem] = nil; h}

    if @users.empty?
      @harvest.users.all.each do |user|
        @users[u.email] = Person.new(info: user, times: @harvest.time.all(@day, user.id))
      end
    else
      all_harvest_users = @harvest.users.all

      @users.each do |k,v|
        all_harvest_users.select{|user| user.email == k }.each do |user|
          @users[k] = Person.new(info: user, times: @harvest.time.all(@day, user.id))
        end
      end
    end
  end

  def employee
    @entries = UserEntries.new(params[:id], @day)
  end

  private

    def set_defaults
      @day = Chronic.parse(params[:date]) || previous_day
      @harvest = Harvest.client( subdomain: Harvest::Application::CONFIG['harvest']['subdomain'],  username: Harvest::Application::CONFIG['harvest']['login_email'],  password: Harvest::Application::CONFIG['harvest']['password'])
    end

    def previous_day
      d = 1.day.ago
      # 0..6, Sun..Sat
      while d.wday < 1 || d.wday > 5
        d = d - 1.day
      end
      d
    end

end