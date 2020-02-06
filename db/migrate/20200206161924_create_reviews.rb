class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :cities_visited
      t.string :likes
      t.string :dislikes
      t.text :must_see
      t.text :if_redo
      t.text :should_know
      t.text :food
      t.text :additional_info
      t.references :user_country, null: false, foreign_key: true

      t.timestamps
    end
  end
end
