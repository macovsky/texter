class CreateTexterTexts < ActiveRecord::Migration
  def change
    create_table :texter_texts do |t|
      t.string :path, :null => false
      t.text :body
    end
    add_index :texter_texts, :path, :unique => true
  end
end
