When /^I send (\d+) packets from (.+) to (.+)$/ do | n_packets, host_a, host_b |
  run "./trema send_packets --source #{ host_a } --dest #{ host_b } --n_pkts #{ n_packets }"
  sleep 5  # ensure that all packets are sent
end


When /^I send 1 packet from (.+) to (.+)$/ do | host_a, host_b |
  step "I send 1 packets from #{ host_a } to #{ host_b }"
  sleep 1  # ensure that all packets are sent
end


When /^I send packets from (.+) to (.+) \(duration = (\d+)\)$/ do | host_a, host_b, duration |
  run "./trema send_packets --source #{ host_a } --dest #{ host_b } --duration #{ duration }"
  sleep 1  # ensure that all packets are sent
end
