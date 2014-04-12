# == Schema Information
#
# Table name: quotes
#
#  id               :integer          not null, primary key
#  phrase           :string(255)
#  content          :text
#  display_date     :date
#  source_detail    :string(255)
#  source_location  :string(255)
#  source_venue     :string(255)
#  source_date      :date
#  publication_name :string(255)
#  publication_type :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

class Quote < ActiveRecord::Base
  include PgSearch
  validates :content, 
            :source_location, :source_detail, presence: true
  validates :phrase,  presence:true, 
                      uniqueness: { case_sensitive: false }
  scope :available, -> { where("display_date < ? OR display_date IS NULL", 1.year.ago) }

  pg_search_scope :search_all_words, 
                  :against => [:content, :source_location]

  pg_search_scope :search_any_word,
                    :against => [:content, :source_location],
                    :using => {
                      :tsearch => { :any_word => true }
                    }

  pg_search_scope :search,
                   :against => [:content, :source_location],
                   :using => {
                    :tsearch => {:dictionary => "english"}
                  }

  scope :exact_match, Proc.new{ |query| where("source_location ilike :q or content ilike :q", q: "%#{query}%") }

   def self.text_search(query, search_type)
   if query.present?
      case search_type

      when "all"
        search_all_words(query)
      when "any"
        search_any_word(query)
      when "exact"
        exact_match(query)
      else
        search(query)
      end
  #     #search(query)#.where("source_location ilike :q or content ilike :q", q: "%#{query}%")
    else
      self.all
   end
 end

  #cronjob to be run everday at midnight + 15 minute
  #wont be necessary if it is okay for first user request of the day to create and cache quote via Quote#for_today
  def self.create_quote_for_today
    quote_for_today = select_quote_for_today
    Rails.cache.write("quote/#{Date.today.strftime('%F')}") { quote_for_today }
  end

  def self.for_today
    Rails.cache.fetch("quote/#{Date.today.strftime('%F')}") do
      quote = Quote.where(display_date: Date.today).first
      unless quote.present?
        #in daily cron job first set all display dates of all quotes greater than a year ago to null to make sure we always have available quotes
        quote = select_quote_for_today
      end
      quote
    end
  end

  def previous
    prev_display_date = self.display_date - 1.day
    previous_quote = Quote.find_by(display_date: prev_display_date)
  end

  def next
    return false if self.display_date == Date.today
    next_display_date = self.display_date + 1.day
    next_quote = Quote.find_by(display_date: next_display_date)   
  end

  private
    def select_quote_for_today
      available_quotes_count = Quote.available.count()
      quote = Quote.available.offset(rand(available_quotes_count)).first
      quote.update_attribute('display_date', Date.today)
      quote
    end
end
