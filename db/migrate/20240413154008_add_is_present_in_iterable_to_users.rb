class AddIsPresentInIterableToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_present_in_iterable, :boolean
  end
end