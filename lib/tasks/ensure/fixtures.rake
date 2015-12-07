namespace :ensure do
  desc 'Ensure fixtures directory'
  file 'fixtures' do
    mkdir 'fixtures'
  end
end
