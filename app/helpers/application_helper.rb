module ApplicationHelper
  def player_color_class(player_color)
    case player_color.downcase
    when 'gold'
      'bg-yellow-300'
    when 'silver'
      'bg-gray-300'
    when 'bronze'
      'bg-orange-300'
    else
      'bg-white'
    end
  end
end
