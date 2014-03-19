class User < ActiveRecord::Base
  has_secure_password

  has_many :permissions

  validates :email, presence: true, uniqueness: true

  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end
end
