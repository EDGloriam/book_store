class AddOmniAuthToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :image, :text
    add_column :users, :name, :text
  end
end
