# frozen_string_literal: true

require 'stringio'

def stream_output(cmd)
  STDOUT.sync = true
  system cmd
  STDOUT.sync = false
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
