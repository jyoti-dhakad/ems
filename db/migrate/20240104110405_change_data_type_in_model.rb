class ChangeDataTypeInModel < ActiveRecord::Migration[6.1]
  def change
    change_column :leaves, :status, :integer, default: 0
  end
end
