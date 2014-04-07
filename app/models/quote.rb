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
  def self.create_quote_for_today
    recycleable_quotes = Quote.where("display_date < ?", 1.year.ago)
    if recycleable_quotes.present?
      recylceable_quotes.each do |quote|
        quote.display_date = nil
        quote.save
      end
    end
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
    display_date = self.display_date - 1.day
    previous_quote = Quote.find_by(display_date: display_date)
  end

  def next
    return false if self.display_date == Date.today
    display_date = self.display_date + 1.day
    next_quote = Quote.find_by(display_date: display_date)   
  end

  private
    def select_quote_for_today
      available_quote_count = Quote.where(display_date: nil).count()
      quote = Quote.limit(1).offset(rand(available_quote_count)).where(display_date: nil).first
      quote.display_date = Date.today
      quote.save
      quote
    end
end
