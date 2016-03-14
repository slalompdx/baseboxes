require 'stringio'

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

def capture_stdout(&_block)
  original_stdout = $stdout
  $stdout = fake = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
  fake.string
end

def toplevel_dir
  `git rev-parse --show-toplevel`.chomp
end

def build_ssh_command(ssh_config)
  "ssh -o StrictHostKeyChecking=no -i #{ssh_config['IdentityFile']} " \
    "-p #{ssh_config['Port']} #{ssh_config['User']}@#{ssh_config['HostName']}"
end

class Array
  def promote(promoted_element)
    return self unless (found_index = find_index(promoted_element))
    unshift(delete_at(found_index))
  end
end
