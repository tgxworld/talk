require 'socket'
require 'fileutils'
require 'rbtrace'

server = UNIXServer.new("/tmp/test.sock")

def accept_connection(server)
  begin
    puts "\n\n\n"

    socket = server.accept

    while (line = socket.readline) != "\r\n"
      puts line
    end

    puts "\n\n\n"

    socket.write("HTTP/1.1 200 OK\n\nYay connection received at #{Time.now.to_s}")
  ensure
    socket&.close
  end
end

begin
  loop do
    accept_connection(server)
  end
ensure
  FileUtils.remove('/tmp/test.sock')
end
