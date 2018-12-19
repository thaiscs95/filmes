class UserVotos < ActiveRecord::Migration[5.2]
  def change

    create_table :uservotos do |t|
      t.belongs_to :user, null: false, index: true
      t.belongs_to :film, null: false, index: true
      t.column :action, :string, null: false, limit: 7
    end
  end
end
