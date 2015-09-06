RSpec::Matchers.define :contains_count do |count, expected|
  match do |actual|
    actual.to_s.scan(expected).length == count
  end
  description do
    "contain #{count} counts of #{expected}"
  end
  failure_message do |actual|
    "expected that '#{actual}' would contain #{count} count(s) of #{expected}"
  end
  failure_message_when_negated do |actual|
    "expected that '#{actual}' would not contain #{count} count(s) of #{expected}"
  end
end
