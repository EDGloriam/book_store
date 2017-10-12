class CreateCreditCards < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_cards do |t|
      t.string :number
      t.string :name
      t.string :mmyy
      t.string :cvv

      t.timestamps
    end
  end
end
