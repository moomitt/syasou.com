class CreateGoods < ActiveRecord::Migration[6.1]
  def change
    create_table :goods do |t|
      t.references :comment, foreign_key: true, null: false
      t.references :user,    foreign_key: true, null: false
      t.timestamps
    end
  end
end
