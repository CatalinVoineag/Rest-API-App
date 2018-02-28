class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|

    	t.string  :element
    	t.integer :url_id
    	t.text 	  :content

      t.timestamps
    end
  end
end
