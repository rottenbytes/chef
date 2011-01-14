# dumps ohai facts to YAML
# created to fasten use of ohai with mcollective
# all credits goes to R.I. Pienaar for the ohai_flatten function
#
# nico <nico@rottenbytes.info>

require 'ohai'

module Fotolia
  class DumpOhai

    def initialize(target)
      @target = target
    end

    def ohai_flatten(key, val, keys, result)
        keys << key
        if val.is_a?(Mash)
            val.each_pair do |nkey, nval|
                ohai_flatten(nkey, nval, keys, result)

                keys.delete_at(keys.size - 1)
            end
        else
            key = keys.join(".")
            if val.is_a?(Array)
                result[key] = val.join(", ")
            else
                result[key] = val
            end
        end
    end

    def report
      oh = Ohai::System.new
      oh.all_plugins
      facts = {}

      oh.data.each_pair do |key, val|
          ohai_flatten(key,val, [], facts)
      end

      fp=open(@target,"w")
      fp.write(facts.to_yaml)
      fp.close
    end
  end
end
