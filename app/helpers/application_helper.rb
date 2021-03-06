module ApplicationHelper

# Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Krishnamurti Information Network"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def twitterized_type(type)
    case type.to_sym
      when :alert
        "alert-danger"
      when :error
        "alert-danger"
      when :notice
        "alert-info"
      when :success
        "alert-success"
      else
        type.to_s
    end
  end

  def country_options_for_select(selected, opts)
    countries = Carmen::Country.all
    #courtesy of carmen-rails gem
    region_options_for_select(countries, selected, opts)
  end

end
