class User < ApplicationRecord
  acts_as_paranoid
  extend Enumerize
  enumerize :role, in: { general: 0, admin: 1 }, default: :general, predicates: true, scope: true
  attr_accessor :remember_token, :reset_password_token
  has_secure_password
  validates :email, presence: true, length: { maximum: 191 }, uniqueness: true
  validates :password_digest, presence: true
  has_many :articles

  # 渡された文字列をハッシュ化して返す
  # min_cost == trueになるのはテスト時
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

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update(remember_digest: nil, remember_created_at: nil)
  end

  def create_reset_password_token
    self.reset_password_token = User.new_token
    update_attributes!(reset_password_token_digest: User.digest(reset_password_token), reset_password_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    Admin::UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_password_sent_at < 1.hours.ago
  end
end
