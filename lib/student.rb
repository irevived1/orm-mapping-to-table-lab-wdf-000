class Student
	attr_accessor :name, :grade
	def initialize (name, grade, id = nil)
		@name = name
		@grade = grade
		@id = id
	end
	def id
		@id
	end
	def self.create_table
		DB[:conn].execute("CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY , name TEXT, grade INTEGER);")
	end
	def self.drop_table
		DB[:conn].execute("DROP TABLE IF EXISTS students;")
	end
	def save
		DB[:conn].execute("INSERT INTO students (name, grade) VALUES ( ? , ? );",@name,@grade)
		@id = DB[:conn].execute("SELECT MAX(id) FROM students;")[0][0]
	end
	def self.create(name:,grade:)
		#i have no idea what i did below, but looks fancy
		stuff = Student.new(name,grade).tap(&:save)
	end
end
