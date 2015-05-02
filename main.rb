require 'sinatra'
require 'open3'

configure do
  set :server, :puma
  set :bind, '0.0.0.0'
  set :port, 3030
end

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

class Stream
  def initialize(command)
    @command = command
  end

  def each
    stdin, stdout_and_stderr, wait_thr = Open3.popen2e(@command)

    begin
      while true
        yield stdout_and_stderr.readpartial(2048)
      end
    rescue EOFError
      yield wait_thr.value.to_s
    end

    stdin.close
    stdout_and_stderr.close
  end
end

get('/') { erb :index }
post('/execute') { Stream.new(params[:command]) }
