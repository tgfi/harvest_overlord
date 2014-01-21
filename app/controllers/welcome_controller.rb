class WelcomeController < ApplicationController

  def index
    @day = Chronic.parse(params[:date]) || previous_day
    @users = Harvest::Application::CONFIG['user_emails'].to_s.gsub(' ', '').split(',').inject({}) { |h, elem| h[elem] = nil; h}

    harvest = Harvest.client( Harvest::Application::CONFIG['harvest']['subdomain'],  Harvest::Application::CONFIG['harvest']['login_email'],  Harvest::Application::CONFIG['harvest']['password'])

    if @users.empty?
      harvest.users.all.each do |user|
        @users[u.email] = Person.new(info: user, times: harvest.time.all(@day, user.id))
      end
    else
      all_harvest_users = harvest.users.all

      @users.each do |k,v|
        all_harvest_users.select{|user| user.email == k }.each do |user|
          @users[k] = Person.new(info: user, times: harvest.time.all(@day, user.id))
        end
      end
    end
  end

  private

    def previous_day
      d = 1.day.ago
      # 0..6, Sun..Sat
      while d.wday < 1 || d.wday > 5
        d = d - 1.day
      end
      d
    end

end