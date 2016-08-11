desc 'Create blobs dir and download updates ISO'
task :winblob do
  system 'mkdir blobs && cd blobs'
  progress_bar = nil
  open('https://s3-us-west-2.amazonaws.com/slalompdx-appdev/ISO/Windows/Updates/wsusoffline-w63-x64.iso',
    content_length_proc: proc { |total|
      if total.to_i > 0
        progress_bar = ProgressBar.create(title: 'Downloaded', total: total)
      end
  },
  progress_proc: proc { |step|
    progress_bar.progress = step
  }) { |file| 
    saved_file.write(file.read) 
    puts "File wsusoffline-w63-x64.iso successfully downloaded"
  }
end