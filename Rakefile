desc "List the Amazon EC2 servers"
task :list do
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
  print `knife ec2 server list`
end
