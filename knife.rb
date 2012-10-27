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
organisation = File.basename(validation_pem, ".pem").gsub(/-.*/, "")
client = File.basename(client_pem, ".pem").gsub(/-.*/, "")
