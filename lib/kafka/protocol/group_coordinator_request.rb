module Kafka
  module Protocol
    class GroupCoordinatorRequest
      def initialize(options={})
        group_id = options[:group_id]

        @group_id = group_id
      end

      def api_key
        10
      end

      def encode(encoder)
        encoder.write_string(@group_id)
      end

      def response_class
        GroupCoordinatorResponse
      end
    end
  end
end
