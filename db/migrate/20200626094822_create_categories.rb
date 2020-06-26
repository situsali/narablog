class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.string :description

      t.timestamps
    end
  end
end
