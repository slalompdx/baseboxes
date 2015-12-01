def stream_output(cmd)
  PTY.spawn(cmd) do |stdout, _stdin, _pid|
    begin
      # Do stuff with the output here. Just printing to show it works
      stdout.each { |line| print line }
    rescue Errno::EIO
      puts 'Errno:EIO error, but this probably just means ' \
           'that the process has finished giving output'
    end
  end
rescue PTY::ChildExited
  puts 'The child process exited!'
end
