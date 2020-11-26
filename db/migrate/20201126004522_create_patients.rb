class CreatePatients < ActiveRecord::Migration[6.0]
  def change
    create_table :patients do |t|
      t.string :name
      t.string :p_lastname
      t.string :m_lastname
      t.date :birth
      t.string :emergency_number
      t.string :phase
      t.string :hexa_code

      t.timestamps
    end
  end
end
