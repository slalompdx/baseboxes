# frozen_string_literal: true

desc 'Create blobs dir and download SQL Server ISO'
task :sqlblob do
  FileUtils.mkdir_p 'blobs'

  Net::HTTP.start('s3-us-west-2.amazonaws.com', use_ssl: true) do |http|
    path = '/slalompdx/ISO/Microsoft/en_sql_server_2012_enterprise_edition_with_service_pack_3_x64_dvd_7286819.iso'
    local_path = 'blobs/sqlserver_2012_ee_sp3.iso'
    response = http.request_head path
    remote_file_size = response['content-length'].to_i
    local_file_size = File.size?(local_path).to_i
    if local_file_size >= remote_file_size
      puts 'File already downloaded.'
      exit 0
    end
    puts "Local: #{local_file_size} Remote: #{remote_file_size}"
    progressbar = ProgressBar.create(total: remote_file_size,
                                     starting_at: local_file_size,
                                     format: '%t: |%B| %e')
    counter = 0
    begin
      f = open(local_path, 'ab')
      begin
        request = Net::HTTP::Get.new(path)
        request.range = (local_file_size..remote_file_size)
        http.request request do |resp|
          resp.read_body do |segment|
            f.write(segment)
            counter += segment.length
            progressbar.progress += segment.length
          end
        end
      ensure
        f.close
      end
    rescue StandardError => e
      puts "Download failed: #{e}"
      exit 1
    end
    resp = http.get(
      '/slalompdx/ISO/Microsoft/en_sql_server_2012_enterprise_edition_with_service_pack_3_x64_dvd_7286819.iso'
    )
    open('blobs/sqlserver_2012_ee_sp3.iso', 'wb') do |file|
      file.write(resp.body)
    end
  end
  puts 'Done.'
end
