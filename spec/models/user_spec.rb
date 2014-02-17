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
#

require 'spec_helper'

describe User do
  before do
    @user = User.new(fname: "Andrea", lname: "Singh", email: "andrea@example.com", password: "secret")
  end
  subject { @user }
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:admin) }

  #associations
  it {should respond_to(:classifieds)}

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end
    it { should be_admin }
  end

  describe "when first name not present" do
    before { @user.fname = " " }
    it { should_not be_valid }
  end

  describe "when  first name is too long" do
    before { @user.fname = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
      it "should be invalid" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                       foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |invalid_address|
          @user.email = invalid_address
          expect(@user).not_to be_valid
        end
      end
    end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "classifieds association" do
    before { @user.save  }
    let!(:newer_classified) { FactoryGirl.create(:classified, user: @user, created_at: 1.hour.ago) }
    let!(:older_classified) { FactoryGirl.create(:classified, user: @user, created_at: 1.day.ago) }
    
    it "should have classifeds ordered by created_at DESC " do
      expect(@user.classifieds.to_a).to eq([newer_classified, older_classified])
    end

    it "should destroy associated classifeds" do
      classifieds = @user.classifieds.to_a
      @user.destroy
      expect(classifieds).not_to be_empty
      classifieds.each do |classified|
        expect(Classified.where(id: classified.id)).to be_empty
      end
    end
    
  end

end
