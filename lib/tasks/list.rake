desc 'List images'
task :list do
  list = Array.new
  Dir.glob("#{toplevel_dir}/*.json") do |file|
    list << file.split('.').first.split('/').last
  end
  list.promote('windows-7').promote('centos-7').promote('centos-6')
  puts list
end
