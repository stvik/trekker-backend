class AddScoreToCities < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :score, :float
  end
end
