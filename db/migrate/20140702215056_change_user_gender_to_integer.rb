class ChangeUserGenderToInteger < ActiveRecord::Migration
  def change
    gender_table = []

    User.all.each do |user|
      gender_table[user.id] = user.gender
    end

    remove_column :users, :gender, :boolean
    add_column :users, :gender, :integer, default: 1

    User.all.each do |user|
      if gender_table[user.id] == true
        user.gender = 2
      elsif gender_table[user.id] == false
        user.gender = 1
      end

      user.save
    end
  end
end
