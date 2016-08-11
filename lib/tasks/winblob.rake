desc 'Create blobs dir and download updates ISO'
task :clean do
  system 'mkdir blobs'
  Net::HTTPS.start("https://s3-us-west-2.amazonaws.com") do |http|
    resp = http.get("/slalompdx-appdev/ISO/Windows/Updates/wsusoffline-w63-x64.iso")
    open("wsusoffline-w63-x64.iso", "wb") do |file|
      file.write(resp.body)
    end
  end
  puts "Blobs dir created and ISO downloaded\n"
end