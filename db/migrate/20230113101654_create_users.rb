class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :cin
      t.string :nom
      t.string :prenom
      t.date :datenaissance
      t.string :email
      t.string :password_digest
      t.integer :role 
      t.integer :balance, default: 20
      t.timestamps 
     
    end
  end
end
