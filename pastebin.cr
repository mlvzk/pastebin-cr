require "http"
require "file"
require "random/secure"

server = HTTP::Server.new do |context|
  case context.request.method
  when "POST"
    next if context.request.content_length.not_nil! > 256 * 1024 * 1024
    HTTP::FormData.parse(context.request) do |part|
      next if part.name != "file"

      generated_name = Random::Secure.urlsafe_base64 6
      File.open("files/#{generated_name}", "w") { |f| IO.copy(part.body, f) }
      context.response << generated_name
    end
  when "GET"
    File.open("files/#{context.request.path.split('/')[1]}") { |f| IO.copy f, context.response.output }
  end
end

server.bind_tcp 3000
server.listen
