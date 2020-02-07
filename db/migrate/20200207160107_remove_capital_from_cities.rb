class RemoveCapitalFromCities < ActiveRecord::Migration[6.0]
  def change

    remove_column :cities, :capital, :boolean
  end
end
