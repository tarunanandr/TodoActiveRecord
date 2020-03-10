require "active_record"

class Todo < ActiveRecord::Base
  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_date == Date.today ? nil : due_date
    "#{id}. #{display_status} #{todo_text} #{display_date}"
  end

  def self.overdue
    where("due_date < ?", Date.today)
  end

  def self.duetoday
    where("due_date = ?", Date.today)
  end

  def self.duelater
    where("due_date > ?", Date.today)
  end

  def self.show_list
    puts "My Todo-list\n\n"
    puts "Overdue\n"
    puts overdue.map {|todo| todo.to_displayable_string}
    puts "\n\n"
    puts "Due Today\n"
    puts duetoday.map {|todo| todo.to_displayable_string}
    puts "\n\n"
    puts "Due Later\n"
    puts duelater.map {|todo| todo.to_displayable_string}
    puts "\n\n"
  end

  def self.add_task(h)
    create!(todo_text: h[h.keys[0]], due_date: Date.today + h[h.keys[1]], completed: false)
  end

  def self.mark_as_complete!(todo_id)
    todo=find(todo_id)
    todo.completed = true
    todo.save
    return todo
  end

end
