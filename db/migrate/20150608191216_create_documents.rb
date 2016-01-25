class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.string :specialty
      t.string :business_type
      t.string :document_type, :string

      t.timestamps null: false
    end
  end
end
