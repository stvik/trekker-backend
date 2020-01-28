class CreateUserCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :user_countries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :country, null: false, foreign_key: true
      t.boolean :visited
      t.boolean :travel_goal
      t.text :recommendation

      t.timestamps
    end
  end
end
