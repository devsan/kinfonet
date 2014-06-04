class Quote < ActiveRecord::Base
  module ForToday
    extend ActiveSupport::Concern
    included do
      scope :available, -> { where("display_date < ? OR display_date IS NULL", 1.year.ago) }
    end
    
    module ClassMethods     
      #run this as daily cron job first set all display dates of all quotes greater than a year ago to null to make sure we always have available quotes
      # Rails.cache.read('quote/2014-06-03')
      def create_quote_for_today
        unless quote_for_today.present?
          quote_for_today = select_quote_for_today
          Rails.cache.write("quote/#{Date.today.strftime('%F')}") { quote_for_today }
        end
      end
     
      def for_today
        Rails.cache.fetch("quote/#{Date.today.strftime('%F')}") do
          unless quote = quote_for_today.presence
            quote = select_quote_for_today
          end
          quote
        end
      end

      def select_quote_for_today
        available_quotes_count = Quote.available.count()
        quote = Quote.available.offset(rand(available_quotes_count)).first
        quote.update_attribute('display_date', Date.today)
        quote
      end

      def quote_for_today
        Quote.where(display_date: Date.today).first
      end
    end
  
  end
end