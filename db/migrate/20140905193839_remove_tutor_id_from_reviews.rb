class RemoveTutorIdFromReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :tutor_id, :integer
  end
end
