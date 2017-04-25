require 'socket'
require 'fileutils'

begin
  server = UNIXServer.new("/tmp/test.sock")

  puts "Accepting new connections"
  socket = server.accept

  puts "Connection received"

  while (line = socket.readline) != "\r\n"
    puts line
  end

  socket.write("HTTP/1.1 200 OK\n\nYay connection received at #{Time.now.to_s}")
ensure
  socket&.close
  FileUtils.remove('/tmp/test.sock')
end

