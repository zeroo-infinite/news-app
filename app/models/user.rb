class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, length: { maximum: 191 }, uniqueness: true
  validates :password, presence: true
  validates :role, presence: true, numericality: true, inclusion: { in: [0, 1] }
end
