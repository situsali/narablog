class ChangeDefaultValueForIsadminFromUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :isadmin, :boolean, default: false
  end
end
