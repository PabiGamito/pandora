#Example

# every 3.hours do
#   runner "MyModel.some_process"
#   rake "my:rake:task"
#   command "/usr/bin/my_great_command"
# end

# every 1.day, :at => '4:30 am' do
#   runner "MyModel.task_to_run_at_four_thirty_in_the_morning"
# end

# every :hour do # Many shortcuts available: :hour, :day, :month, :year, :reboot
#   runner "SomeModel.ladeeda"
# end

# every :sunday, :at => '12pm' do # Use any day of the week or :weekend, :weekday
#   runner "Task.do_something_great"
# end

# every '0 0 27-31 * *' do
#   command "echo 'you can use raw cron syntax too'"
# end

# # run this task only on servers with the :app role in Capistrano
# # see Capistrano roles section below
# every :day, :at => '12:20am', :roles => [:app] do
#   rake "app_server:task"
# end

# JOBTYPES
# job_type :command, ":task :output"
# job_type :rake,    "cd :path && :environment_variable=:environment bundle exec rake :task --silent :output"
# job_type :runner,  "cd :path && bin/rails runner -e :environment ':task' :output"
# job_type :script,  "cd :path && :environment_variable=:environment bundle exec script/:task :output"


#Runs investment/loan transactions
every 1.day, :at => '12am' do
  runner "Loan.repay_loans"
end

#Runs end of day transaction calculations
# every 2.hours
#   runner "Company.calculations"
# end

# every :sunday, :at => '12am'
#   runner "Company.weekly_reset"
# end




