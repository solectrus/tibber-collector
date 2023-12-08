require 'dotenv/load'
require 'active_support/core_ext/kernel/reporting'

# Suppress warning about circular dependency in gem "graphql-client"
# https://github.com/github/graphql-client/pull/304
silence_warnings do
  require 'graphql/client'
  require 'graphql/client/http'
end

class Tibber
  def initialize(config:)
    @config = config
  end

  attr_reader :config

  def price_info
    response = Client.query(PRICE_INFO_QUERY, context: { config: })

    if response.errors.blank?
      puts 'OK'
      response.data.viewer.homes.first.current_subscription.price_info
    else
      puts "Error #{response.errors[:data].join(', ')}"
    end
  end

  def dump_schema
    FileUtils.rm_f(SCHEMA_FILENAME)

    GraphQL::Client.dump_schema(HTTP, SCHEMA_FILENAME, context: { config: })
  end

  private

  BASE_URL = 'https://api.tibber.com/v1-beta/gql'.freeze
  SCHEMA_FILENAME = 'schema.json'.freeze

  HTTP =
    GraphQL::Client::HTTP.new(BASE_URL) do
      def headers(context)
        return {} unless context[:config]

        {
          'Authorization' => "Bearer #{context[:config].tibber_token}",
          'User-Agent' => 'SOLECTRUS/Tibber-Collector',
        }
      end
    end

  Schema =
    GraphQL::Client.load_schema(
      File.exist?(SCHEMA_FILENAME) ? SCHEMA_FILENAME : HTTP,
    )

  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)

  PRICE_INFO_QUERY = Client.parse <<-GRAPHQL
    query {
      viewer {
        homes {
          currentSubscription{
            priceInfo{
              today {
                total
                startsAt
                level
              }
              tomorrow {
                total
                startsAt
                level
              }
            }
          }
        }
      }
    }
  GRAPHQL
end
