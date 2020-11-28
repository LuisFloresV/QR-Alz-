class AddExtraFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :p_lastname, :string
    add_column :users, :m_lastname, :string
    add_column :users, :speciality, :string
  end
end
