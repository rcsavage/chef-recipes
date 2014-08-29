#######################################################
### Check to see if I am a container or not          ##
#######################################################

$is_container = "false"

class DockerContainerDetect 
  File.open("/proc/1/cgroup") do |file|
    file.each do |line|
      if (line.include? ('memory') and line.include? ('docker'))
          puts "Found active Docker container"
          $is_container = "true"
      end
    end
  end
end


if $is_container == "false"
  hostsfile_entry node['ipaddress'] do
    hostname node['hostname']
    comment "Updated by Chef"
    action :create
    unique true
  end
end
