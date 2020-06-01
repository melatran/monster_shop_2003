class ChangeStatusToString < ActiveRecord::Migration[5.1]
  def change
    change_column :orders, :status, :string, default: "Pending"
  end
end
