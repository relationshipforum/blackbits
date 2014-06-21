class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: :slugged

  has_many :submissions, foreign_key: "author_id"
  has_many :posts, foreign_key: "author_id"
  has_many :thanks
  has_many :views, dependent: :destroy

  validates :avatar_url, format: { with: /(png|jpe?g)\Z/, allow_nil: true }

  def avatar_url
    read_attribute(:avatar_url) || "pixel-admin/avatar.png"
  end

  def friendly_gender
    gender == false ? "female" : "male"
  end

  def to_s
    username
  end

  attr_accessor :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :gender, inclusion: { in: [false, true] }

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    else
      where(conditions).first
    end
  end
end
