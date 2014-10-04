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

  def top_posts
    Post.unscoped.
      where(author: self).
      where("deleted_at IS NULL").
      where("thanks_count IS NOT NULL AND thanks_count > 0").
      order("thanks_count DESC").
      limit(10)
  end

  # This method returns data for the "Loved By" and "Favorite Posters" tables
  # in the user profile.
  def most_thanks(mine)
    mine = (mine == :loved_by)

    if mine
      sql = <<EOS
        SELECT  user_id,
                COUNT(user_id) AS thanks_count
        FROM    thanks
        WHERE   thanks.post_id IN
                  (SELECT id FROM posts WHERE posts.author_id = #{id})
                  AND
                  thanks.deleted_at IS NULL
        GROUP BY user_id
        ORDER BY thanks_count DESC
        LIMIT 10
EOS
    else
      sql = <<EOS
        SELECT      posts.author_id AS user_id,
                    COUNT(posts.author_id) AS thanks_count
        FROM        thanks
        INNER JOIN  posts
        ON          posts.id = thanks.post_id
        WHERE       user_id = #{id}
        GROUP BY    posts.author_id
        ORDER BY    thanks_count DESC
        LIMIT 10
EOS
    end

    chart = ActiveRecord::Base.connection.execute(sql).to_a
    
    User.where("id IN (?)", chart.map { |res| res["user_id"] }).map do |user|
      [user, chart.find { |res| res["user_id"].to_i == user.id }["thanks_count"].to_i ]
    end.sort_by { |lover| lover[1] }.reverse
  end

  def unread_messages_count
    join = <<EOS
    INNER JOIN
      (
        SELECT    conversation_id,
                  MAX(created_at)
        AS        last_chat_at
        FROM      chats
        GROUP BY  conversation_id
      )
    AS chats
    ON chats.conversation_id = conversations_users.conversation_id
EOS

    ConversationsUser.joins(join).
      where(user_id: id).
      where("conversations_users.read_at IS NULL OR conversations_users.read_at < chats.last_chat_at").
      count
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
