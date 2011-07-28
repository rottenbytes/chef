require "rubygems"
require "stomp"
require "base64"

conf = YAML.load_file("summarize.conf")

cnx=Stomp::Client.new(conf[:stomp_user], conf[:stomp_password], conf[:stomp_server], conf[:stomp_port], true)

cnx.subscribe(conf[:stomp_queue], { :ack => :client }) do |data|
  infos=Marshal.load(Base64.decode64(data.body))
  puts infos.inspect
  cnx.acknowledge data
end
cnx.join
cnx.close
