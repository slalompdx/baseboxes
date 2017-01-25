pv = {
  'boot_wait'         => '10s',
  'disk_size'         => '40960',
  'headless'          => 'true',
  'http_directory'    => 'http',
  'iso_checksum'      => '907e5755f824c5848b9c8efbb484f3cd945e93faa024bad6ba875226f9683b16',
  'iso_checksum_type' => 'sha256',
  'iso_url'           => '{{user `mirror`}}/{{user `mirror_directory`}}/{{user `iso_name`}}',
  'name'              => 'centos-7',
  'shutdown_command'  => 'echo "vagrant" | sudo -S /sbin/halt -h -p',
  'ssh_password'      => 'vagrant',
  'ssh_port'          => '22',
  'ssh_username'      => 'vagrant',
  'ssh_wait_timeout'  => '10000s',
}
env_pv = {
  'box_basename'      => 'centos-7',
  'build_timestamp'   => '{{isotime "20060102150405"}}',
  'git_revision'      => '__unknown_git_revision__',
  'http_proxy'        => '{{env `http_proxy`}}',
  'https_proxy'       => '{{env `https_proxy`}}',
  'iso_name'          => 'CentOS-7-x86_64-DVD-1511.iso',
  'ks_path'           => 'centos-7/ks.cfg',
  'metadata'          => 'floppy/dummy_metadata.json',
  'mirror'            => 'http://mirrors.kernel.org/centos',
  'mirror_directory'  => '7.2.1511/isos/x86_64',
  'no_proxy'          => '{{env `no_proxy`}}',
  'template'          => 'centos-7',
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
    'output_directory'     => 'packer-{{user `template`}}-virtualbox',
    'vboxmanage'           => {
      'memory' => [ 'modifyvm', '{{.Name}}', '--memory', '480' ],
      'cpu'    => [ 'modifyvm', '{{.Name}}', '--cpus', '1' ]
    },
    'virtualbox_version_file' => '.vbox_version',
    'vm_name'                 => '{{ user `template` }}'
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
    'output_directory'    => 'packer-{{user `template`}}-vmware',
    'tools_upload_flavor' => 'linux',
    'vm_name'             => '{{ user `template` }}',
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