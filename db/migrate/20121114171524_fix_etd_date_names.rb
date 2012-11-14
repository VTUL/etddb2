class FixEtdDateNames < ActiveRecord::Migration
  def change
    rename_column :etds, :ddate, :defense_date
    rename_column :etds, :sdate, :submission_date
    rename_column :etds, :adate, :approval_date
    rename_column :etds, :rdate, :release_date
    remove_column :etds, :cdate
  end
end
