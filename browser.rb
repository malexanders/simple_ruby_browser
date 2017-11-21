require 'uri'
require 'pry'
require 'socket'

class SimpleBrowser
  def initialize(uri)
    uri = URI(uri)
    @host = uri.host
    @port = uri.port
  end

  def send_request
    # Retrieve IP for hostname
    ip_address = IPSocket.getaddress(@host)

    # Open Socket for ip_address and port
    socket = TCPSocket.open(ip_address, @port)

    # Build request
    request = "GET / HTTP/1.1\n" +
              "Host: #{@host}\n" +
              "Sec-WebSocket-Key: GUcEf8gY7brnvd7S9D6EPQ==\n" +
              "\n"

    # Write request to socket
    socket.print(request)

    # Read response from socket
    socket.read
  end
end

# Accept URI as command line argument
browser = SimpleBrowser.new(ARGV[0])

# GET resource from server
response = browser.send_request

# Print resource to the commandline
puts response

