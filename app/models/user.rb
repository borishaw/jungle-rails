class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews
  validates_uniqueness_of :email, case_sensitive: false
  validates_presence_of :first_name, :last_name
  validates :password, length: { minimum: 8 }

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.to_s.downcase.strip)
    user && user.authenticate(password) ? user : nil
  end

end