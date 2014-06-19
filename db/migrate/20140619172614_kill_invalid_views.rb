class KillInvalidViews < ActiveRecord::Migration
  def change
    View.order("id ASC").all.each do |view|
      view.destroy unless view.valid?
    end
  end
end
