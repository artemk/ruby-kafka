module Kafka
  module Protocol
    class HeartbeatRequest
      def initialize(options={})
        group_id = options[:group_id]
        generation_id = options[:generation_id]
        member_id = options[:member_id]

        @group_id = group_id
        @generation_id = generation_id
        @member_id = member_id
      end

      def api_key
        12
      end

      def response_class
        HeartbeatResponse
      end

      def encode(encoder)
        encoder.write_string(@group_id)
        encoder.write_int32(@generation_id)
        encoder.write_string(@member_id)
      end
    end
  end
end
