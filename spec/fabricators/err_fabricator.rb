Fabricator :err do
  problem
  fingerprint 'some-finger-print'
end

Fabricator :notice do
  err
  message             'FooError: Too Much Bar'
  backtrace
  server_environment  { {'environment-name' => 'production'} }
  request             {{ 'component' => 'foo', 'action' => 'bar' }}
  notifier            {{ 'name' => 'Notifier', 'version' => '1', 'url' => 'http://toad.com' }}
end

Fabricator :notice_with_commit, from: :notice do
  request             {{ "component" => "foo", "action" => "bar", "cgi-data" => {"GIT_COMMIT" => SecureRandom.hex(20)} }}
end


Fabricator :backtrace do
  lines(count: 99) { Fabricate.build(:backtrace_line) }
end

Fabricator :backtrace_line do
  backtrace { Backtrace.create! }
  number { rand(999) }
  file { "/path/to/file/#{SecureRandom.hex(4)}.rb" }
  method(:method) { ActiveSupport.methods.shuffle.first }
end
