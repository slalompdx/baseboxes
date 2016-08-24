# frozen_string_literal: true

desc 'Create blobs dir and download updates ISO'
task :winblob do
  FileUtils.mkdir_p 'blobs'

  Net::HTTP.start('s3-us-west-2.amazonaws.com', use_ssl: true) do |http|
    resp = http.get(
      '/slalompdx-appdev/ISO/Windows/Updates/wsusoffline-w64-x64.iso'
    )
    open('blobs/wsusoffline-w63-x64.iso', 'wb') do |file|
      file.write(resp.body)
    end
  end
  puts 'Done.'
end
