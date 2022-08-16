# OmniAuth::Web3ID

Web3ID OAuth2 Strategy for OmniAuth.

### What is web3id?

- please refer to [official website](https://www.dock.io/web3id)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-web3id'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-web3id

## Usage

- Generate your `key/secret` by following [oauth2 setup instructions](https://github.com/docknetwork/auth-server/blob/master/docs/oauth2_setup.md).

- Add omniauth builder middleware to your ruby app

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :web3id, ENV['WEB3ID_KEY'], ENV['WEB3ID_SECRET']
end
```

## Devise integration

- Please refer to [example rails application](https://github.com/robinbortlik/web3id-rails)

## Showcase


https://user-images.githubusercontent.com/228502/184993116-945f2cb3-70d3-4902-b7ac-81c23e5892ac.mov


## Final note

This gem was heavily inspired by [omniauth-microsoft-office365](https://github.com/murbanski/omniauth-microsoft-office365) gem. Thank you guys for your hard work.
