class AddAgeToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :age, :string
  end
end
