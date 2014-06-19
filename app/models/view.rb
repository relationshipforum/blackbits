class View < ActiveRecord::Base
  before_create :set_viewed_at_to_now

  validates_uniqueness_of :submission_id, scope: :user_id

  private
  def set_viewed_at_to_now
    self.viewed_at = Time.now
  end
end
