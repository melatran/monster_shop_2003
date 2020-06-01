class ChangeDataTypeForStatus < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :stats
    add_column :orders, :status, :integer, default: 1
  end
end
