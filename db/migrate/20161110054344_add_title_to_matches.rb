class AddTitleToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :title, :string
  end
end
