class AddCompleteStepToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :complete_step, :string
  end
end
