class Films < ActiveRecord::Migration[5.2]
  def change
    create_table :films do |t|
      t.column :movie_url, :string, null: false, index: true, limit: 250
      t.column :name, :text, null: false
      t.column :year, :integer, null: false, limit: 4
      t.column :like, :integer, default: 0
      t.column :dislike, :integer, default: 0
      t.column :director, :text, null:false
      t.column :episode, :integer, null:false
    end
  end
end