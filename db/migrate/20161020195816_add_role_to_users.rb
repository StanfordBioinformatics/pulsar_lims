class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :integer, default: User::VIEWER_ROLE
  end
end
