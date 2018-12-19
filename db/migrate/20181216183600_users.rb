class Users < ActiveRecord::Migration[5.2]

  def change 
    create_table :users do |t|
      t.column :nome, :text, null: false
      t.column :email, :string, null: false, index: true, limit: 100
      t.column :senha, :text, null: false
    end
  end
end