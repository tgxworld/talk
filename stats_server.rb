require 'socket'
require 'fileutils'
require 'json'

class StatsServer

  def initialize(socket_path)
    @socket_path = socket_path
    @server = nil
  end

  def start
    @server = UNIXServer.new(@socket_path)
    spawn_thread
  end

  def stop
    @server.close if @server
    @server = nil
    FileUtils.rm(@socket_path)
  end

  private

    def spawn_thread
      Thread.new do
        done = false

        while !done
          done = !accept_connection(@server)
        end
      end
    end

    def accept_connection(server)
      socket = nil

      begin
        socket = server.accept
      rescue IOError
        return false
      end

      command = socket.readline

      output =
        case command.chomp
        when "gc stat"
          GC.stat.to_json
        else
          "Invalid Command\n"
        end

      socket.write(output)

      true
    ensure
      socket&.close
    end
end
