class CreatePools < ActiveRecord::Migration
  def change
    create_table :pools do |t|
      t.references :match, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
