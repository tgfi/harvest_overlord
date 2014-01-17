class WelcomeController < ApplicationController

  def index

    @day = Chronic.parse(params[:date]) || previous_day

    harvest = Harvest.client( Harvest::Application::CONFIG['harvest']['subdomain'],  Harvest::Application::CONFIG['harvest']['login_email'],  Harvest::Application::CONFIG['harvest']['password'])
    # harvest.projects.all   # list out projects

    # client = Harvest::Client.new(:name => "Billable Company LTD.")
    # client = harvest.clients.create(client)
    # harvest.clients.find(client.id) # returns a Harvest::Client

    @users = Harvest::Application::CONFIG['user_emails'].to_s.gsub(' ', '').split(',').inject({}) { |h, elem| h[elem] = nil; h}
     # {"mgilbank@tgfi.net" => nil, "msellers@tgfi.net" => nil, "mretzak@tgfi.net" => nil, "gbenedict@tgfi.net" => nil}

    # get all users
    h_users = harvest.users.all

    # update our local hash
    @users.each do |k,v|
      p = Person.new()
      p.info = h_users.select{|u| u.email == k }.first
      # raise p
      p.times = harvest.time.all(@day, p.info.id)

      @users[k] = p
    end

  end

  private

    def previous_day
      d = 1.day.ago
      # 0..6, Sun..Sat
      while d.wday < 2 || d.wday > 5
        d = d - 1.day
      end
      d
    end

end