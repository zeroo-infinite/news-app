class User < ApplicationRecord
  acts_as_paranoid
  attr_accessor :remember_token
  has_secure_password
  validates :email, presence: true, length: { maximum: 191 }, uniqueness: true
  validates :password_digest, presence: true
  validates :role, presence: true, numericality: true, inclusion: { in: [0, 1] }

  # 渡された文字列をハッシュ化して返す
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにトークンをDBに保存する
  def remember
    self.remember_token = User.new_token
    update(remember_digest: User.digest(remember_token), remember_created_at: Time.zone.now)
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update(remember_digest: nil, remember_created_at: nil)
  end
end
