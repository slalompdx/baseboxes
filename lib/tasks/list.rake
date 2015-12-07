desc 'List images'
task :list do
  Dir.glob('*.json') do |file|
    puts file.split('.').first
  end
end
