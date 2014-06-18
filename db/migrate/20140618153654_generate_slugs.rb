class GenerateSlugs < ActiveRecord::Migration
  def change
    [User, Forum, Submission].each { |i| i.find_each(&:save) }
  end
end
