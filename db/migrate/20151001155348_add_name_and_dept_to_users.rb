class AddNameAndDeptToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :first_name, :string, :after => :email
  	add_column :users, :last_name, :string, :after => :first_name
  	add_column :users, :department, :string, :after => :last_name
  end
end
