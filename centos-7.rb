require 'dotenv/load'
require 'nenv'
Dotenv.load('default.env', 'centos-7.env')

pv = {
  'boot_wait'         => Nenv.boot_wait,
  'disk_size'         => Nenv.disk_size,
  'headless'          => Nenv.headless,
  'http_directory'    => Nenv.http_directory,
  'iso_checksum'      => Nenv.iso_checksum,
  'iso_checksum_type' => Nenv.iso_checksum_type,
  'iso_url'           => '{{user `mirror`}}/{{user `mirror_directory`}}/{{user `iso_name`}}',
  'shutdown_command'  => Nenv.shutdown_command,
  'ssh_password'      => Nenv.ssh_password,
  'ssh_port'          => Nenv.ssh_port,
  'ssh_username'      => Nenv.ssh_username,
  'ssh_wait_timeout'  => Nenv.ssh_wait_timeout,
}
env_pv = {
  'box_basename'      => Nenv.box_basename,
  'build_timestamp'   => '{{isotime "20060102150405"}}',
  'git_revision'      => '__unknown_git_revision__',
  'http_proxy'        => Nenv.http_proxy,
  'https_proxy'       => Nenv.https_proxy,
  'iso_name'          => Nenv.iso_name,
  'ks_path'           => Nenv.ks_path,
  'metadata'          => Nenv.metadata,
  'mirror'            => Nenv.mirror,
  'mirror_directory'  => Nenv.mirror_directory,
  'no_proxy'          => Nenv.no_proxy,
  'version'           => '2.1.TIMESTAMP'
}

Racker::Processor.register_template do |t|
  # Define variables
  t.variables = pv.merge(env_pv)

  # Define the builders
  t.builders['virtualbox-vagrant'] = {
    'type'                 => 'virtualbox-iso',
    'boot_command'         => {
      0                    => "<tab> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/{{user `ks_path`}}<enter><wait>",
    },
    'floppy_files'         => [
      'http/centos-7/ks.cfg'
    ],
    'guest_additions_path' => 'VBoxGuestAdditions_{{.Version}}.iso',
    'guest_os_type'        => 'RedHat_64',
    'hard_drive_interface' => 'sata',
    'output_directory'     => 'packer-{{user `box_basename`}}-virtualbox',
    'vboxmanage'           => {
      'memory' => [ 'modifyvm', '{{.Name}}', '--memory', '480' ],
      'cpu'    => [ 'modifyvm', '{{.Name}}', '--cpus', '1' ]
    },
    'virtualbox_version_file' => '.vbox_version',
    'vm_name'                 => '{{ user `box_basename` }}'
  }.merge(pv)

  t.builders['vmware-vagrant'] = {
    'type' => 'vmware-iso',
    'boot_command'         => {
      0                    => "<tab> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/{{user `ks_path`}}<enter><wait>",
    },
    'floppy_files'         => [
      'http/centos-7/ks.cfg'
    ],
    'guest_os_type'       => 'centos-64',
    'output_directory'    => 'packer-{{user `box_basename`}}-vmware',
    'tools_upload_flavor' => 'linux',
    'vm_name'             => '{{ user `box_basename` }}',
    'vmx_data'            => {
      'cpuid.coresPerSocket' => '1',
      'memsize'              => '480',
      'numvcpus'             => '1'
    },
    'vnc_port_min' => 5900,
    'vnc_port_max' => 5910
  }.merge(pv)

  t.provisioners = {
    0 => {
      'upload_metadata' => {
        'type'          => 'file',
        'source'        => '{{user `metadata`}}',
        'destination'   => '/tmp/bento-metadata.json'
      },
    },
    10 => {
      'main_configuration' => {
        'type'             => 'shell',
        'environment_vars' => [
          'HOME_DIR=/home/vagrant',
          'http_proxy={{user `http_proxy`}}',
          'https_proxy={{user `https_proxy`}}',
          'no_proxy={{user `no_proxy`}}'
        ],
        'execute_command'  => 'echo "vagrant" | {{.Vars}} sudo -S -E sh -eux "{{.Path}}"',
        'scripts'          => [
          'scripts/common/metadata.sh',
          'scripts/common/sshd.sh',
          'scripts/centos/networking.sh',
          'scripts/common/vagrant.sh',
          'scripts/common/vmtools.sh',
          'scripts/centos/7/cleanup.sh',
          'scripts/common/minimize.sh'
        ]
      }
    }
  }
  
  t.postprocessors['vagrant'] = {
    'type'                => 'vagrant',
    'output'              => 'builds/{{user `box_basename`}}.{{.Provider}}.box',
    'keep_input_artifact' => true,
  }
end