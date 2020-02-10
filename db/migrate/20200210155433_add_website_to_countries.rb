class AddWebsiteToCountries < ActiveRecord::Migration[6.0]
  def change
    add_column :countries, :website, :string
  end
end
