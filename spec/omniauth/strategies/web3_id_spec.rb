# frozen_string_literal: true

require "spec_helper"

RSpec.describe OmniAuth::Strategies::Web3ID do
  let(:request)      { double("Request", params: {}, cookies: {}, env: {}) }
  let(:access_token) { instance_double(OAuth2::AccessToken) }
  let(:options)      { {} }

  let(:app) do
    lambda do
      [200, {}, ["Hello."]]
    end
  end

  let(:strategy) do
    OmniAuth::Strategies::Web3ID.new(app, "appid", "secret", options)
  end

  before do
    OmniAuth.config.test_mode = true
    allow(strategy).to receive(:request).and_return(request)
    allow(strategy).to receive(:access_token).and_return(access_token)
  end

  after do
    OmniAuth.config.test_mode = false
  end

  describe "#name" do
    it "returns :web3id" do
      expect(strategy.name).to eq(:web3id)
    end
  end

  describe "#client_options" do
    context "with defaults" do
      it "uses correct site" do
        expect(strategy.client.site).to eq("https://auth.dock.io")
      end

      it "uses correct authorize_url" do
        expect(strategy.client.authorize_url).to eq("https://auth.dock.io/oauth2/authorize?response_type=code")
      end

      it "uses correct token_url" do
        expect(strategy.client.token_url).to eq("https://auth.dock.io/oauth2/token")
      end
    end

    context "with customized client options" do
      let(:options) do
        {
          client_options: {
            "site" => "https://example.com",
            "authorize_url" => "https://example.com/authorize",
            "token_url" => "https://example.com/token"
          }
        }
      end

      it "uses customized site" do
        expect(strategy.client.site).to eq("https://example.com")
      end

      it "uses customized authorize_url" do
        expect(strategy.client.authorize_url).to eq("https://example.com/authorize")
      end

      it "uses customized token_url" do
        expect(strategy.client.token_url).to eq("https://example.com/token")
      end
    end
  end

  describe "#authorize_params" do
    context "defaults" do
      it "uses correct scope and grand_type" do
        expect(strategy.authorize_params).to match(
          "state" => /\A\h{48}\z/,
          "grant_type" => "authorization_code",
          "scope" => "public email"
        )
      end
    end

    context "custom params" do
      let(:options) do
        { authorize_params: { foo: "bar", baz: "zip", scope: "public", grant_type: "code" } }
      end

      it "updates authorization parameter" do
        expect(strategy.authorize_params).to match(
          "foo" => "bar",
          "baz" => "zip",
          "state" => /\A\h{48}\z/,
          "grant_type" => "code",
          "scope" => "public"
        )
      end
    end
  end

  describe "#info" do
    let(:profile_response) do
      instance_double(OAuth2::Response, parsed: {
                        "name" => "john",
                        "email" => "john@doe.com",
                        "id" => "did:key:z6MkiFCczu5vAVWqdYQoGruYhFEunRpKustXxCAAccfXLZE4",
                        "user_id" => "did:key:z6MkiFCczu5vAVWqdYQoGruYhFEunRpKustXxCAAccfXLZE4"
                      })
    end

    before do
      expect(access_token).to receive(:get).with("/oauth2/userinfo")
                                           .and_return(profile_response)
    end

    it "returns a hash containing normalized user data" do
      expect(strategy.info).to match({
                                       did: "did:key:z6MkiFCczu5vAVWqdYQoGruYhFEunRpKustXxCAAccfXLZE4",
                                       email: "john@doe.com",
                                       name: "john"
                                     })
    end
  end
end
