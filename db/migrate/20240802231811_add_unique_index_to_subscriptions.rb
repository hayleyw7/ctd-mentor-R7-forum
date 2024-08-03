class AddUniqueIndexToSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_index :subscriptions, [:forum_id, :user_id], unique: true
  end
end
