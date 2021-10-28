require 'socket'
require 'logger'
require './lib/utils'
require './lib/multi_io'


server = TCPServer.new 7777

log_file = File.new("server.log", "a")
logger = Logger.new MultiIO.new(STDOUT, log_file)

app_hash = Hash.new

utils = Utils.new

loop do
  Thread.start(server.accept) do |client|

    request = client.gets.chomp.split(' ')
    logger.info request.to_s

    command = request[0]
    app = request[1]
    argument = request[2]

    if command == "run"
      utils.run(app, app_hash, argument, client)
    elsif command == "close"
      utils.close(app, app_hash, client)
    else
      utils.send_info(client)
    end
    client.close
  end
end
