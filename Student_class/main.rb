require 'json'
require 'yaml'
require_relative 'Entities/Student'
require_relative 'Entities/Student_short'
require_relative 'student_tree'
require_relative 'DataList/data_table'
require_relative 'DataList/data_list'
require_relative 'DataList/data_list_student_short'
require_relative 'Entities/Human'
require_relative 'StudentsListBase'
require_relative 'JSONStrategy'
require_relative 'YAMLStrategy'
require_relative 'file_strategy'
require_relative './Database/Connection'
require_relative './Database/StudentListDB'
require_relative './DataStructure/student_list_adapter'
require_relative './DataStructure/student_list_adapter_DB'
require_relative './Filter/Filter'
require_relative './Filter/FilterDecorator'
require_relative './Filter/empty_github_filter'
require_relative 'student_app'
require 'pg'

require 'fox16'


include Fox



begin
  yaml_strategy = YAMLStrategy.new
  list_adapter1 = Students_list_adapter.new('students_test.yaml', yaml_strategy)



  base=Filter.new()
  filter=EmptyGithubFilter.new(base)
  shrt_list = list_adapter1.get_k_n_student_short_list(1, 10, filter)
  puts shrt_list.get_data
  puts list_adapter1.get_student_short_count(filter)

  db_config = {
    host: 'localhost', user: 'postgres', password: '12345', dbname: 'postgres'
  }
  con = Students_list_DB.instance(db_config)




  list_adapter2 = Students_list_db_adapter.new(db_config)



  short_list=list_adapter2.get_k_n_student_short_list(2, 10, filter)

  puts short_list.get_data
  if __FILE__ == $0
    FXApp.new do |app|
      StudentApp.new(app)
      app.create
      app.run
    end
  end
rescue ArgumentError => e
  puts e.message
end
