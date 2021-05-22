class Task
  attr_reader :id
  attr_accessor :title, :description, :done
  def initialize (attributes = {}) 
  @title = attributes[:title]
  @id = attributes[:id]
  @done = attributes[:done] || false
  @description = attributes[:description]
  # test driven development
  end

  def self.find(id)
    task_new = DB.execute('SELECT * FROM tasks WHERE id = ?', id).first
    build_task(task_new)
  end

  def self.all
    task_hashes = DB.execute('SELECT * FROM tasks')
    task_hashes.map do |task_hash| 
      build_task(task_hash)
    end
  end

  def self.build_task(task_hash)
    task_hash["done"] = task_hash["done"] == "true"
    Task.new(task_hash.transform_keys(&:to_sym))
  end

  def save
    if @id.nil?
      new_task = DB.execute('INSERT INTO tasks(title, description, done) VALUES(?,?,?)', @title, @description, @done.to_s) 
      @id = DB.last_insert_row_id
    else
      DB.execute('UPDATE tasks SET title = ?, description = ?, done = ? WHERE id = ?', @title, @description, @done.to_s, @id)
    end
  end

  def destroy
    DB.execute('DELETE FROM tasks WHERE id = ?', @id)
  end
end