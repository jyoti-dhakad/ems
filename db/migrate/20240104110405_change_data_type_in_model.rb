class ChangeDataTypeInModel < ActiveRecord::Migration[6.1]
  def up
    # Step 1: Pehle default remove karo
    change_column_default :leaves, :status, nil

    # Step 2: Phir data type integer me convert karo
    change_column :leaves, :status, 'integer USING status::integer'

    # Step 3: Default wapas set karo
    change_column_default :leaves, :status, 0
  end

  def down
    # Wapas pehle default remove karo
    change_column_default :leaves, :status, nil

    # Data type string me convert karo
    change_column :leaves, :status, :string

    # Default wapas set karo agar pehle tha
    change_column_default :leaves, :status, "pending"
  end
end
