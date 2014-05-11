if ENV['seeds']
  dates = (1.weeks.ago.to_date..Date.today).to_a
  times = [0.5, 1, 1.5, 2, 4]
  projects = [1,2,3]
  issues = [1,2,3,4,5]

  20.times do
    TimeLog.create(
      time: times.sample,
      day: dates.sample,
      issue_iid: issues.sample,
      project_id: projects.sample,
    )
  end
end
