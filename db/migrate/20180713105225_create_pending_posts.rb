class CreatePendingPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :pending_posts do |t|
      t.references  :user, foreign_key: true
      t.string        :title
      t.text          :body
      t.timestamps
    end
  end
end
