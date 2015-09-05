require 'minitest/spec'
require 'minitest/autorun'

require 'bundler/setup'
Bundler.setup

require 'cap_expect'

def test_root_dir
  File.expand_path('cap_expect/mock_root', File.dirname(__FILE__))
end

def capture(stream)
  begin
    stream = stream.to_s
    eval "$#{stream} = StringIO.new"
    yield
    result = eval("$#{stream}").string
  ensure
    eval("$#{stream} = #{stream.upcase}")
  end

  result
end