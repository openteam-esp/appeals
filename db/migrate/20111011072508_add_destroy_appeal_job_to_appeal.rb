class AddDestroyAppealJobToAppeal < ActiveRecord::Migration
  def change
    add_column :appeals, :destroy_appeal_job_id, :integer
  end
end
