class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.references  :user, null: false, foreign_key: true
      t.string      :title, null: false
      t.string      :slug, null: false
      t.text        :body, null: false
      t.boolean     :published, default: false

      t.timestamps
    end
  end
end
