class AddCachedVotesToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :cached_votes_total, :integer
    add_column :posts, :cached_votes_up, :integer
  end
end
