class User < ActiveRecord::Base
  ROLES = %i[admin banned]

  extend FriendlyId
  friendly_id :username, use: :slugged

  acts_as_paranoid

  has_many :submissions, foreign_key: "author_id"
  has_many :posts, foreign_key: "author_id"
  has_many :thanks
  has_many :views, dependent: :destroy

  has_many :conversations, through: :conversations_users
  has_many :conversations_users

  before_validation :https_avatar_url
  validates :avatar_url, format: { with: /\Ahttps\:\/\/i\.imgur\.com\/(\w+)\.(png|jpe?g)\Z/, allow_nil: true, unless: Proc.new { |user| user.avatar_url == "pixel-admin/avatar.png" } }

  def avatar_url
    read_attribute(:avatar_url) || "pixel-admin/avatar.png"
  end

  def to_s
    username
  end

  def https_avatar_url
    url = avatar_url.to_s
    url.sub!("http:", "https:")
    url = nil if url.blank?

    self.avatar_url = url
  end

  def admin?
    role == "admin"
  end

  def self.lookup(username)
    User.where("lower(username) = ?", username.to_s.strip.downcase).first
  end

  attr_accessor :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :gender, numericality: { less_than_or_equal_to: 2, greater_than_or_equal_to: 0 }

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    else
      where(conditions).first
    end
  end
end
