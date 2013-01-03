# This migration comes from texter (originally 20121231021051)
class CreateTexterTexts < ActiveRecord::Migration
  def change
    create_table :texter_texts do |t|
      t.string :path, :null => false, :default => ''
      t.text :body
      t.timestamps
    end
    add_index :texter_texts, :path, :unique => true
  end
end
