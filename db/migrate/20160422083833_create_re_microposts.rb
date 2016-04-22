class CreateReMicroposts < ActiveRecord::Migration
  def change
    create_table :re_microposts do |t|
      t.references :user, index: true, foreign_key: true
      t.references :micropost, index: true, foreign_key: true

      t.timestamps null: false

      t.index [:user_id, :created_at]
    end
  end
end
