module Kafka
  class ConnectionBuilder
    def initialize(options={})
      client_id = options[:client_id]
      logger = options[:logger]
      instrumenter = options[:instrumenter]
      connect_timeout = options[:connect_timeout]
      socket_timeout = options[:socket_timeout]
      ssl_context = options[:ssl_context]

      @client_id = client_id
      @logger = logger
      @instrumenter = instrumenter
      @connect_timeout = connect_timeout
      @socket_timeout = socket_timeout
      @ssl_context = ssl_context
    end

    def build_connection(host, port)
      Connection.new(
        host: host,
        port: port,
        client_id: @client_id,
        connect_timeout: @connect_timeout,
        socket_timeout: @socket_timeout,
        logger: @logger,
        instrumenter: @instrumenter,
        ssl_context: @ssl_context,
      )
    end
  end
end
