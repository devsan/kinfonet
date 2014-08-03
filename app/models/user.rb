# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  fname                  :string(255)
#  lname                  :string(255)
#  admin                  :boolean          default(FALSE)
#  feedback               :text
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  public_comment         :text
#

class User < ActiveRecord::Base
  has_many :classifieds, dependent: :destroy
  has_one :address, as: :addressable, dependent: :destroy
  before_save :strip_name_fields
  before_save :delete_avatar!, if: :delete_avatar?
  delegate :address1, :address2, :city, :state_code, :country_code, :zip, :lat, :lng, :to => :address

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #https://devcenter.heroku.com/articles/paperclip-s3
  has_attached_file :avatar,
                    :styles => { medium: "140x140#", thumb: "100x100#", mini: "24x24#" },
                    :default_url => ActionController::Base.helpers.asset_path('assets/default_avatar_:style.png'),
                    :path => ":rails_root/public/system/:class/:attachment/:id/:style/:filename",
                    :url => "/system/:class/:attachment/:id/:style/:filename"

  validates_attachment_content_type :avatar,
                                    :content_type => /\Aimage\/.*\Z/,
                                    :message => "is not a valid - it needs to be a gif, png or jpg",
                                    :allow_blank => true
  validates_attachment_file_name  :avatar,
                                  :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/],
                                  :message => "image file name is invalid - should have a gif, png or jpg extension",
                                  :allow_blank => true

  # validates_attachment_size :avatar,
  #                           :less_than => 100.kilobytes,
  #                           :message => "image size is too big; maximum size is 100 kb."

  validates_attachment_size :avatar,
                            :less_than => 250.kilobytes,
                            :message => "Image size is larger that the maximum allowed (100 kilobytes)"

  validates :fname, presence: true
  validates :fname, length: { maximum: 50 }

  accepts_nested_attributes_for :address, allow_destroy: true,
                                          reject_if: :all_blank
  attr_accessor :delete_avatar

  def display_name
    if self.lname.present?
      "#{fname.downcase.capitalize} #{lname[0].upcase}."
    else
      self.fname
    end
  end

  def full_name
    "#{fname} #{lname}"
  end

  private
    def strip_name_fields
      self.fname.strip!
      self.lname.strip! if self.lname.present?
    end

    def delete_avatar?
      self.delete_avatar == "1" && (!self.avatar_file_name_changed?)
    end

    def delete_avatar!
      self.avatar = nil
    end

end
