class CreateSummaries < ActiveRecord::Migration[5.1]
  def change
    create_table :summaries do |t|
      t.string :username, unique: true
      t.jsonb :user_response
      t.jsonb :repos_response

      t.timestamps
    end
    add_index :summaries, :username, unique: true
  end
end
