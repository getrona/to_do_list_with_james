require('rspec')
require('pg')
require('list')
require('spec_helper')
require('pry')

describe(List) do
  describe(".all") do
    it("starts off with no lists") do
      expect(List.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("tells you its name") do
      list = List.new({:name => "Epicodus stuff", :id => nil})
      expect(list.name()).to(eq("Epicodus stuff"))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      list = List.new({:name => "Epicodus stuff", :id => nil})
      list.save()
      expect(list.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save lists to the database") do
      list = List.new({:name => "Epicodus stuff", :id => nil})
      list.save()
      expect(List.all()).to(eq([list]))
    end
  end

  describe("#update") do
    it("lets you update lists in the database") do
      list = List.new({:name => "Epicodus stuff", :id => nil})
      list.save()
      list.update({:name => "Homework stuff"})
      expect(list.name()).to(eq("Homework stuff"))
    end
  end

  describe("#delete_list") do
    it("lets you delete a list from the database") do
      list = List.new({:name => "Epicodus stuff", :id => nil})
      list.save()
      list2 = List.new({:name => "House stuff", :id => nil})
      list2.save()
      # list_found = List.find(166)
      # binding.pry
      list.delete_list()
      expect(List.all()).to(eq([list2]))
    end

    it("deletes a list's tasks from the database") do
     list = List.new({:name => "Epicodus stuff", :id => nil})
     list.save()
     task = Task.new({:description => "learn SQL", :list_id => list.id(), :due_date => "2015-12-10 00:00:00", :status_done => "f"})
     task.save()
     task2 = Task.new({:description => "Review Ruby", :list_id => list.id(), :due_date => "2015-12-10 00:00:00", :status_done => "f"})
     task2.save()
     list.delete_list()
     expect(Task.all()).to(eq([]))
    end
  end

  describe("#==") do
    it("is the same list if it has the same name") do
      list1 = List.new({:name => "Epicodus stuff", :id => nil})
      list2 = List.new({:name => "Epicodus stuff", :id => nil})
      expect(list1).to(eq(list2))
    end
  end
end
