class AddUserIdToPicturemem < ActiveRecord::Migration
  def change
    add_column :picturemems, :user_id, :integer
  end
end
