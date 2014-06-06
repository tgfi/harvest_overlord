class UserEntries < HarvestBase

  def initialize(user_id, date = Date.today)
    @user_id = user_id
    @day = date
  end

  def start_date
    @day.beginning_of_week
  end

  def end_date
    @day.end_of_week
  end

  def entries
    @entries ||= get_entries
  end

  def user
    @user ||= client.users.find(@user_id)
  end

  def hours
    @hours ||= entries.map{ |entry| entry[:times].map{ |t| t.hours } }.flatten.sum
  end

  private

    # def  get_hours
    #   get_hours = 0.00

    # entries.each do |entry|
    #   entry.times.each do |t|
    #     @hours += t.hours
    #   end
    # end

    # @hours

    # end
    def get_entries

      entries = []
      date = start_date.dup

      while date <= end_date
        entries << { :date => date, :times => client.time.all(date, user.id) }
        date += 1.day
      end

      entries

    end



end