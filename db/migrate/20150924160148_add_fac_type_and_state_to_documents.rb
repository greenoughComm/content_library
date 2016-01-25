class AddFacTypeAndStateToDocuments < ActiveRecord::Migration
  def change
  	add_column :documents, :facility_type, :string, :after => :document_type
  	add_column :documents, :state, :string, :after => :facility_type
  end
end
