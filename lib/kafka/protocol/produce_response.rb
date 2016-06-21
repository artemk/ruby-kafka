module Kafka
  module Protocol
    class ProduceResponse
      class TopicInfo
        attr_reader :topic, :partitions

        def initialize(options={})
          topic = options[:topic]
          partitions = options[:partitions]

          @topic = topic
          @partitions = partitions
        end
      end

      class PartitionInfo
        attr_reader :partition, :error_code, :offset

        def initialize(options={})
          partition = options[:partition]
          error_code = options[:error_code]
          offset = options[:offset]

          @partition = partition
          @error_code = error_code
          @offset = offset
        end
      end

      attr_reader :topics

      def initialize(options={})
        topics = options[:topics] || []

        @topics = topics
      end

      def each_partition
        @topics.each do |topic_info|
          topic_info.partitions.each do |partition_info|
            yield topic_info, partition_info
          end
        end
      end

      def self.decode(decoder)
        topics = decoder.array do
          topic = decoder.string

          partitions = decoder.array do
            PartitionInfo.new(
              partition: decoder.int32,
              error_code: decoder.int16,
              offset: decoder.int64,
            )
          end

          TopicInfo.new(topic: topic, partitions: partitions)
        end

        new(topics: topics)
      end
    end
  end
end
