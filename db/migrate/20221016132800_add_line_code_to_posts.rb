class AddLineCodeToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :line_code, :integer
  end
end
