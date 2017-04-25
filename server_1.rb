require 'socket'
require 'fileutils'

begin
  server = UNIXServer.new("/tmp/test.sock")

  puts "Accepting new connections"
  socket = server.accept

  puts "Connection received"
  content = socket.readline

  puts "Received: #{content}"
  socket.write(Process.pid)
ensure
  socket&.close
  FileUtils.remove('/tmp/test.sock')
end
