desc 'Create blobs dir and download updates ISO'
task :winblob do
  system 'mkdir blobs'
=begin
pbar = nil
open('blobs/wsusoffline-w63-x64.iso', 'wb') do |fo|
  fo.print open('https://s3-us-west-2.amazonaws.com/slalompdx-appdev/ISO/Windows/Updates/wsusoffline-w63-x64.iso',
    :content_length_proc => lambda { |t|
    if t && 0 < t
      pbar = ProgressBar.new("...", t)
      pbar.file_transfer_mode
    end
    },

    :progress_proc => lambda {|s|
      pbar.set s if pbar
    }).write
end
=end

pbar = nil
url = URI.parse("https://s3-us-west-2.amazonaws.com/slalompdx-appdev/ISO/Windows/Updates/wsusoffline-w63-x64.iso")
download_file = open("blobs/wsusoffline-w63-x64.iso", "wb")
request = Net::HTTP.new(url.host, url.port)

request.use_ssl = true

# .. set basic auth, verify peer etc

begin
  request.start.request_get(url.path) do |resp|
    puts "File downloading... please wait..."
    resp.read_body { |segment| 
      download_file.write(segment)
    }
  end
ensure
  download_file.close
end
puts "Yay!!"
end