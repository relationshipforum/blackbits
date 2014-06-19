class View < ActiveRecord::Base
  before_create :set_viewed_at_to_now

  private
  def set_viewed_at_to_now
    self.viewed_at = Time.now
  end
end
