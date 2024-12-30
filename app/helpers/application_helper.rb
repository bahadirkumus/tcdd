module ApplicationHelper
  def is_user_logged_in?
    !session[:user_id].nil?
  end

  def time_ago_in_short_format(timestamp)
    distance = Time.current - timestamp
    case distance
    when 0..59.minutes
      "#{(distance / 60).to_i}m" # Dakika
    when 1.hour..23.hours
      "#{(distance / 1.hour).to_i}h" # Saat
    when 1.day..30.days
      "#{(distance / 1.day).to_i}d" # Gün
    else
      "#{(distance / 30.days).to_i}mo" # Ay
    end
  end
end
