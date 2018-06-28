

When /^I try trema kill "([^"]*)"$/ do | component |
  run "./trema kill #{ component }"
end

