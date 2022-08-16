# frozen_string_literal: true

require "omniauth-oauth2"

module OmniAuth
  module Strategies
    # Web3ID authentication strategy.
    class Web3ID < OmniAuth::Strategies::OAuth2
      option :name, :web3id

      DEFAULT_SCOPE = "public email"

      option :client_options, {
        site: "https://auth.dock.io",
        authorize_url: "/oauth2/authorize?response_type=code",
        token_url: "/oauth2/token",
        profile_url: "/oauth2/userinfo"
      }
      option :authorize_params, { grant_type: "authorization_code", scope: DEFAULT_SCOPE }
      option :authorize_options, %w[scope]
      option :provider_ignores_state, true

      uid { raw_info_did }

      info do
        {
          did: raw_info_did,
          email: raw_info["email"],
          name: raw_info["name"]
        }
      end

      extra do
        {
          "raw_info" => raw_info
        }
      end

      def raw_info_did
        raw_info["id"] || raw_info["user_id"]
      end

      def raw_info
        @raw_info ||= access_token.get(client.options[:profile_url]).parsed
      end

      def callback_url
        options[:redirect_uri] || (full_host + script_name + callback_path)
      end
    end
  end
end
