class HarvestBase

  def client
    @harvest ||= Harvest.client( subdomain: Harvest::Application::CONFIG['harvest']['subdomain'],  username: Harvest::Application::CONFIG['harvest']['login_email'],  password: Harvest::Application::CONFIG['harvest']['password'])
  end
end