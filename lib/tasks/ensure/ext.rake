# frozen_string_literal: true

namespace :ensure do
  desc 'Ensure ext/ directory'
  task 'ext' do
    FileUtils.mkdir_p 'ext'
  end
end
