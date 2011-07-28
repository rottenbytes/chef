require "chef/handler"

module Mycorp
    class Summarize < Chef::Handler
    attr_accessor :conf
  
    def initialize(args)
      self.conf = YAML.load_file(args[:configfile])
    end

    def report
    
      begin
        require "rubygems"
        require "stomp"
        require "base64"
        
        ignored_resources = [ "/var/cache/chef/handlers",
                              "Chef::Handler::Mycorp::Summarize"
                            ]
        report_resources= []
        updated_resources.each do |r|
          if !ignored_resources.include?(r.name) then
            report_resources.push r.name
          end
        end
        
        summary = { :nodename => node.name.dup,
                    :elapsed_time => elapsed_time,
                    :start_time => start_time,
                    :end_time => end_time,
                    :updated_resources => report_resources
                  }
        
        cnx=Stomp::Client.new(self.conf[:stomp_user], self.conf[:stomp_password], self.conf[:stomp_server], self.conf[:stomp_port], true)
        msg=Base64.encode64(Marshal.dump(summary))
        cnx.publish(self.conf[:stomp_queue], msg, {:persistent => false})
      rescue Exception => e
        Chef::Log.error("Could not summarize and send back data for this run ! (#{e})")
      end
    end

  end # end of class Summarize
end
