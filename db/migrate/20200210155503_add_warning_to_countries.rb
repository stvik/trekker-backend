class AddWarningToCountries < ActiveRecord::Migration[6.0]
  def change
    add_column :countries, :warning, :string
  end
end
