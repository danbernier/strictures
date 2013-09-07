require 'rake/testtask'

Rake::TestTask.new do |t|
  t.name = 'spec'
  t.libs << 'specs'
  t.test_files = FileList['specs/**/*_spec.rb']
end

task default: :spec
