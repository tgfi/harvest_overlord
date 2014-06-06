class HarvestBase

  def client
    @harvest ||= Harvest.client( Harvest::Application::CONFIG['harvest']['subdomain'],  Harvest::Application::CONFIG['harvest']['login_email'],  Harvest::Application::CONFIG['harvest']['password'])
  end
end