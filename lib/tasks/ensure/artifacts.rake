namespace :ensure do
  desc 'Ensure artifacts directory'
  task 'artifacts' do
    FileUtils.mkdir_p 'artifacts'
  end
end
