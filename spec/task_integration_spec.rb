require('capybara/rspec')
require('spec_helper')
require('./app')
require('list')
require('spec_helper')
require('task')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new list', {:type => :feature}) do
  it('allows a user to click a list to see the tasks and details for it') do
    visit('/')
    fill_in('name', :with => 'Yardwork')
    click_button('Make list!')
    expect(page).to have_content('The list has been successfully submitted!')
  end
end

describe('viewing all of the lists', {:type => :feature}) do
  it('allows a user to see all of the lists that have been created') do
    visit('/')
    fill_in('name', :with => 'Homework')
    click_button('Make list!')
    click_link('Back')
    expect(page).to have_content('Homework')
  end
end

describe('seeing tasks for a list', {:type => :feature}) do
  it('allows user to see tasks associated with a list') do
    visit('/')
    fill_in('name', :with => 'Homework')
    click_button('Make list!')
    click_link('Back')
    click_link('Homework')
    expect(page).to have_content('Here is a list of your tasks:')
  end
end

# describe('adding tasks to a list', {:type => :feature}) do
#   it('allows user to add tasks associated to a list') do
#     visit('/')
#     fill_in('name', :with => 'Homework')
#     click_button('Make list!')
#     click_link('Back')
#     click_link('Homework')
#     fill_in('description', :with => 'Epicodus SQL Lessons')
#     fill_in('due_date', :with => '2016-12-20')
#     click_button('Add task!')
#     click_link('Back')
#     click_link('Homework')
#     expect(page).to have_content('Epicodus SQL Lessons')
#   end
# end
