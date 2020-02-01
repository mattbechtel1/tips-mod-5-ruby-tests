require 'active_support'
require 'active_support/core_ext'

class RecurringMoment
  def initialize(start:, interval:, period:)
    @start = start
    @interval = interval
    @period = period
  end

  def match(date)
    current = @start

    if @period == 'monthly'
      day_of_month = current.day
    end

    while current <= date # loop was originally only testing for 'less than', changed to <= to enable it to hit true
      if current == date
        return true
      end

      if @period == 'monthly'
        current = current.advance(months: @interval)  #this line and line under the weekly boolean were originally switched
        while day_of_month > current.day && current.month == current.advance(days: 1).month #added logic to account for dates late in the month
          current = current.advance(days: 1)
        end
      elsif @period == 'weekly' # bugfix from assignment '=' to boolean statement
        current = current.advance(weeks: @interval)
      elsif @period == 'daily'
        current = current.advance(days: @interval)
      end
    end

    return false
  end
end
