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
  include ForToday #concern: daily quote creation 
  
  validates :content, 
            :source_location, :source_detail, presence: true
  validates :phrase,  presence:true, 
                      uniqueness: { case_sensitive: false }
  
  default_scope { order("quotes.display_date DESC NULLS LAST") }


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

  scope :archived, -> { where("display_date IS NOT NULL and display_date <= ?", Date.today) }

   def self.text_search(query, search_type)
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
 end

  def previous
    unless self.display_date.blank?
      prev_display_date = self.display_date - 1.day
      previous_quote = Quote.find_by(display_date: prev_display_date)
    end
  end

  def next
    return false if self.display_date == Date.today
    unless self.display_date.blank?
      next_display_date = self.display_date + 1.day
      next_quote = Quote.find_by(display_date: next_display_date)
    end  
  end

end
