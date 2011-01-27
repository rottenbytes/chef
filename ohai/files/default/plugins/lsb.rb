provides "lsb/distcodename"

lsb Mash.new

if os == "linux" then
  lsb[:distcodename] = `/usr/bin/lsb_release -c -s`.chomp
end



