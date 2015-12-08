desc 'List images'
task :list do
  Dir.glob("#{toplevel_dir}/*.json") do |file|
    puts file.split('.').first.split('/').last
  end
end
