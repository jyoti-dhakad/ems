class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.integer :staff_id
      t.string :document_type
      t.timestamps
    end
  end
end
