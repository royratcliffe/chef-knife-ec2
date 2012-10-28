# If possible, set up the environment by sourcing aws.sh in the enclosing
# folder. Let the shell interpreter parse the shell source. Use the env binary
# to print out the environment variables. Select the variables prefixed by
# AWS-underscore. Import these into our ENV.
aws_sh = File.join(File.dirname(__FILE__), 'aws.sh')
`sh -c "source "#{aws_sh}" ; env"`.split("\n").select do |any_line|
  any_line =~ /^AWS_/
end.map do |aws_line|
  aws_line.split("=", 0)
end.each do |key_value_pair|
  ENV[key_value_pair[0]] = key_value_pair[1]
end if File.exist?(aws_sh)

# Configure a new Knife instance. Tell it to configure itself in order to pick
# up the Knife configuration information from the usual places, namely at
# .chef/knife.rb.
require 'chef/knife'
knife = Chef::Knife.new
knife.configure_chef

require 'chef/knife/ec2_base'
class Chef
  class Knife
    # Require the dependencies immediately. Override the default implementation
    # by running the requirements block right now. Define dependencies becomes
    # load dependencies. Subsequently mix in the EC2 base methods, such as
    # #connection, to the Chef::Knife class.
    def self.deps(&block)
      block.call
    end
    include Chef::Knife::Ec2Base
  end
end

desc "List the Amazon EC2 servers"
task :list do
  print `knife ec2 server list`
end

desc "List EC2 server instances that use a given image"
task :list_all_instances_with_image_id, [:image_id] do |t, args|
  knife.connection.servers.each do |server|
    puts server.id if server.image_id == args.image_id
  end
end
