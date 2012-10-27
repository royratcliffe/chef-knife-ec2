# Chef Configuration
#
# There should be at least two PEM files in the enclosing folder. One of them
# specifies the organisation's validation key; the one whose name ends with
# dash-validator or dash-validation. Pick out the first matching PEM if more
# than one exists. The other PEM specifies the client key; the one named
# something dash-client. Use the names of the PEM files to determine the name of
# the organisation and the name of the client node.
#
enclosing_folder = File.dirname(__FILE__)
validation_pem = Dir["#{enclosing_folder}/*-validat{or,ion}.pem"][0]
client_pem = Dir["#{enclosing_folder}/*-client.pem"][0]
organisation = File.basename(validation_pem, File.extname(validation_pem)).gsub(/-.*/, "")
client = File.basename(client_pem, File.extname(client_pem)).gsub(/-.*/, "")

log_level                :info
log_location             STDOUT
node_name                client
client_key               client_pem
validation_client_name   "#{organisation}-validator"
validation_key           validation_pem
chef_server_url          "https://api.opscode.com/organizations/#{organisation}"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{enclosing_folder}/../cookbooks"]

# Amazon Web Services
#
# Pull the Amazon access keys from the Unix environment. Do not embed the keys
# within the source tree. Otherwise the keys will appear within the Git
# repository. Not wise. Instead, first load the environment by storing the keys
# within an external script, for example. Source the script then run Knife
# commands.
#
# Use a shell script containing the following; see exports below. With the
# environment loaded, you can use Knife to list the EC2 server nodes using
# "knife ec2 server list". You will need to install the Knife gem as well as the
# knife-ec2 gem which adds EC2 support for Chef's Knife command.
#
#   export AWS_SSH_KEY_ID="XXXXXXXXXXXXXXXXXXXX"
#   export AWS_ACCESS_KEY_ID="XXXXXXXXXXXXXXXXXXXX"
#   export AWS_SECRET_ACCESS_KEY="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
#
knife[:aws_ssh_key_id] = ENV['AWS_SSH_KEY_ID']
knife[:aws_access_key_id] = ENV['AWS_ACCESS_KEY_ID']
knife[:aws_secret_access_key] = ENV['AWS_SECRET_ACCESS_KEY']
