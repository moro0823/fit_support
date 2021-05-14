class AddSexToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :sex, :integer
  end
end
