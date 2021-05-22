require "sqlite3"
DB = SQLite3::Database.new("tasks.db")
DB.results_as_hash = true
require_relative "task"

# READ 
task = Task.find(1)
puts "#{task.title} - #{task.description}"

# CREATE
new_task = Task.new(title: 'Laundry', description: 'Handle dirty T-shirts')
new_task.save
p new_task

# UPDATE
task = Task.find(1)
p task
puts "#{task.done ? "[X]" :  "[ ]"} #{task.title} - #{task.description}"

task.done = true
task.save
p task

# READ ALL
tasks = Task.all
tasks.each do |task|
  puts "#{task.done ? "[X]" :  "[ ]"} #{task.title} - #{task.description}"
end

# DESTROY
task = Task.find(1)
task.destroy
p Task.all