class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :firstname
      t.string :lastname
      t.text :bio
      t.string :location
      t.string :image

      t.timestamps
    end
  end
end
