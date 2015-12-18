class User < ActiveRecord::Base
  include Clearance::User

  has_many :authentications, :dependent => :destroy, foreign_key: 'user_id'
  
  def self.create_with_auth_and_hash(authentication,auth_hash)
    # byebug
    create! do |u|
    byebug
      u.first_name = auth_hash["info"]["first_name"]
      u.last_name = auth_hash["info"]["last_name"]
      u.name = auth_hash["info"]["name"]
      u.email = auth_hash["extra"]["raw_info"]["email"]
      u.password = '12345'
      u.authentications<<(authentication)

    end
  end

  
  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end
  
  
  def password_optional?
    true
  end
end
