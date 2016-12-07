require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/task')
require('pg')
require('./lib/list')
require('pry')

DB = PG.connect({:dbname => "to_do"})

# Index Routing
get('/') do
  # Grabs all list entries from the list table
    # This is iterated through on the index page for displaying
  @returned_lists = List.all()
  erb(:index)
end
  # Button routing
get('/new_list') do
  erb(:index)
end
  # From the button
post('/new_list') do
  # Grabs inputted name for list entry
  name = params.fetch('name')
  # Creates a new list object and saves it to the database lists table
  List.new({:name => name, :id => nil}).save()
  erb(:success)
end
# End Index Routing

# List Page (and task form) routing
get('/list/:id') do
  # id and list variables grab the correct list entry from the lists table
  id = (params.fetch('id').to_i)
  list = List.find(id)
  # Grab name and ID for list entry display
  @current_list_name = list.name
  @current_list_id = list.id
  # Grabs the tasks from ONLY the corresponding list_id
  @current_tasks = Task.find(id)
  # binding.pry
  erb(:list)
end

get("/lists/:id/edit") do
  @list = List.find(params.fetch("id").to_i())
  erb(:list_edit)
end

patch("/lists/:id") do
  name = params.fetch("name")
  @list = List.find(params.fetch("id").to_i())
  @list.first().update({:name => name})
  erb(:list)
end

delete("/lists/:id") do
  @list = List.find(params.fetch("id").to_i())
  @list.delete_list()
  @lists = List.all()
  erb(:index)
end
# End List Page routing

post('/tasks-form/') do
  description = params.fetch('description')
  due_date = params.fetch('due_date')
  list_id = params.fetch('list_id').to_i
  Task.new({:description => description, :due_date => due_date, :status_done => 'f', :list_id => list_id}).save()
  erb(:success)
end

# Sorted Tasks Routing
get('/sort_tasks_asc/:id') do
  list_id = params.fetch('id')
  # Returns date-sorted task table rows into an array variable
  @sorted_tasks_array = Task.sort_tasks_by_date_asc(list_id)
  erb(:sorted_tasks)
end

post('/sorted_tasks') do
  @sorted_tasks_array
  erb(:sorted_tasks)
end
# End Sorted Tasks Routing
