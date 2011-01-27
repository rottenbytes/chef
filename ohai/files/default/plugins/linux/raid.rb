provides 'raid/devices'

raid Mash.new

# Sample data
# HP
# 03:00.0 RAID bus controller: Hewlett-Packard Company Smart Array G6 controllers (rev 01)
# Areca
# 10:00.0 RAID bus controller: Areca Technology Corp. Device 1680
# Dell
# 02:0e.0 RAID bus controller: Dell PowerEdge Expandable RAID controller 5

re=Regexp.new("(.*) RAID bus controller: (.*)")

devices=Array.new

`/usr/bin/lspci | /bin/grep -i raid`.each_line do |l|
  m=re.match(l)
  if m then
    data=Hash.new
    data[:pciid] = m[1]
    data[:vendor] = m[2].split(" ")[0]
    data[:fulldescription] = m[2]
    devices.push(data)
  end
end

raid[:devices]=devices
