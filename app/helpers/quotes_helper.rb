module QuotesHelper

  def previous_quote_link(current_quote)
    previous_quote = current_quote.previous
    if previous_quote.present?
      content_tag(:span, link_to('&laquo;&laquo; previous quote'.html_safe, quote_path(previous_quote)), :id => 'previous-quote')
    else
      content_tag(:span, content_tag(:span, "&laquo;&laquo; previous quote".html_safe, :class => 'text-muted'), :id => 'previous-quote')
    end
  end
  
  def next_quote_link(current_quote)
    next_quote = current_quote.next
    if next_quote.present?
      content_tag(:span, link_to('next quote &raquo;'.html_safe, quote_path(next_quote)), :id => 'next-quote')
    else
      content_tag(:span, content_tag(:span, "next quote &raquo;&raquo;".html_safe, :class => 'text-muted'), :id => 'next-quote')
    end
  end
end