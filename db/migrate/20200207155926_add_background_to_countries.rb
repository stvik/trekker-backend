class AddBackgroundToCountries < ActiveRecord::Migration[6.0]
  def change
    add_column :countries, :background, :string
  end
end
