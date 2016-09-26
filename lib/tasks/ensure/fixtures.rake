# frozen_string_literal: true

namespace :ensure do
  desc 'Ensure fixtures directory'
  task 'fixtures' do
    FileUtils.mkdir_p 'fixtures/vagrant'
  end
end
