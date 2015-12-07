namespace :ensure do
  desc 'Ensure artifacts directory'
  file 'artifacts' do
    mkdir 'artifacts'
  end
end
