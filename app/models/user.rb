class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login
  # Setup accessible (or protected) attributes for your model
  attr_accessible  :login,:email, :password, :password_confirmation, :remember_me,:username,
          :role,:avatar
  has_one:profile
  has_many:posts
  has_many:comments
  #validates_associated :profile  # 查验指定的对象。

 after_create :set_profile
   def set_profile
     @profile = self.build_profile
   end

 protected
   def self.find_for_database_authentication(warden_conditions)    #指定用户名或email登录
   conditions = warden_conditions.dup
   login = conditions.delete(:login)
   where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.strip.downcase }]).first
 end

end
