desc 'List images'
task :list do
  list = Hash.new
  Dir.glob("#{toplevel_dir}/*.json") do |file|
    item = file.split('.').first.split('/').last
    unless list[item.count('-')]
      list[item.count('-')] = Array.new
    end
    list[item.count('-')] << item
  end
  list.sort.each do |key, value|
    puts value
  end
end
