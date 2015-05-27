class Application
  property :port
  property :name
  property :verbose
  property :routes
  property :controllers

  def initialize(name= __FILE__, @port=8080)
    @name ||= File.basename(name).gsub(/.\w+\Z/, "")
    @run_string = "[Amethyst #{Time.now}] serving application \"#{@name}\" at http://127.0.0.1:#{port}" #TODO move to Logger class
    @middleware_stack = MiddlewareStack.new
    @router = Router.new
  end

  def routes
    @router
  end
    
  def use(middleware : BaseMiddleware)
    @middleware_stack.add(middleware)
  end

  def serve()
    puts @run_string
    server = HTTP::Server.new @port, BaseHandler.new(@middleware_stack, @router)
    server.listen
  end
end