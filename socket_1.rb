require 'socket'

begin
  socket = UNIXSocket.new("/tmp/test.sock")

  puts "Writing to socket..."
  socket.write("Hello World from #{Process.pid}\n")

  puts "Reading response"
  puts socket.readline
ensure
  socket&.close
end
