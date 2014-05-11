class TimeLog < ActiveRecord::Base
  validates_presence_of :time, :day, :issue_iid, :project_id, :user_id
end
