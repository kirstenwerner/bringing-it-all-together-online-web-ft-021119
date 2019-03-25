class Dog 
  
  attr_accessor :name, :breed
  attr_reader :id 
  
  def initialize(name:, breed:, id: nil)
    @name = name
    @breed = breed 
    @id = id 
  end 
  
  def self.create_table 
    sql = <<-SQL 
      CREATE TABLE dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
        );
        SQL
    
    DB[:conn].execute(sql)  
  end 
  
  def self.drop_table
    sql = "DROP TABLE dogs"
    DB[:conn].execute(sql)
  end 
  
  def save
    if self.id 
      self.update
    else 
    sql = <<-SQL
      INSERT INTO dogs (name, breed)
      VALUES (?, ?)
      SQL
    
    DB[:conn].execute(sql, self.name, self.breed)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    self
    end
  end
  
  def self.create(attribute_hash)
    new_dog = self.new(attribute_hash[name:], attribute_hash[breed:], attribute_hash[id:]) 
    new_dog.save
  end
  
end 