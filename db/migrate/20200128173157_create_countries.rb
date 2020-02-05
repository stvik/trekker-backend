class CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :continent
      t.float :latitude
      t.float :longitude
      t.string :languages
      t.string :currency
      t.integer :population
      t.string :flag
      t.string :country_code
      t.text :description

      t.timestamps
    end
  end
end
