class ChangeColumnSubmitterCommentsInBiosamplesToText < ActiveRecord::Migration
  def change
    change_column :biosamples, :submitter_comments, :text
  end
end
