class CreateMyFitnessPlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :my_fitness_places do |t|
      t.integer :customer_id
      t.integer :admin_user_id

      t.timestamps
    end
  end
end
