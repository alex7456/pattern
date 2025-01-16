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
require_relative './Filter/sort_by_fullname_filter'
require_relative 'student_app'
require 'pg'

require 'fox16'


include Fox



begin
  db_config = { host: 'localhost', user: 'postgres', password: '12345', dbname: 'postgres' }
  if __FILE__ == $0
    FXApp.new do |app|
      StudentApp.new(app, db_config)
      app.create
      app.run
    end
  end
rescue ArgumentError => e
  puts e.message
end
