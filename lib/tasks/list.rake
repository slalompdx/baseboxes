desc 'List images'
task :list do
  list = {}
  Dir.glob("#{toplevel_dir}/*.json") do |file|
    item = file.split('.').first.split('/').last
    list[item.count('-')] = [] unless list[item.count('-')]
    list[item.count('-')] << item
  end
  list.sort.each do |_key, value|
    puts value
  end
end
