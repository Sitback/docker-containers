i = 0
files = [
  'php55_spec.rb',
  'php54_spec.rb',
  'php53_spec.rb',
]
build_files = []

files.each do |file|
  if (i % ENV['CIRCLE_NODE_TOTAL'].to_i) == ENV['CIRCLE_NODE_INDEX']
    build_files.push file
  end
  i++
end

build_files.each do |file|
  system("bundle exec rspec spec/soe/#{file}")
end
