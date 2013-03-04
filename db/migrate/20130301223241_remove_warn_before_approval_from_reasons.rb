class RemoveWarnBeforeApprovalFromReasons < ActiveRecord::Migration
  def up
    remove_column :reasons, :warn_before_approval
  end

  def down
    add_column :reasons, :warn_before_approval, :boolean
  end
end
