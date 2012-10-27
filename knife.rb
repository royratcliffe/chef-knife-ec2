enclosing_folder = File.dirname(__FILE__)
validation_pem = Dir["#{enclosing_folder}/*-validat{or,ion}.pem"][0]
client_pem = Dir["#{enclosing_folder}/*-client.pem"][0]
organisation = File.basename(validation_pem, ".pem").gsub(/-.*/, "")
