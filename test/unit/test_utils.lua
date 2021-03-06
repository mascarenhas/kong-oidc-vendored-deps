local utils = require("kong.plugins.oidc.utils")
local lu = require("luaunit")
-- opts_fixture, ngx are global to prevent mutation in consecutive tests
local opts_fixture = nil
local ngx = nil

TestUtils = require("test.unit.base_case"):extend()

function TestUtils:setUp()
  -- reset opts_fixture
  opts_fixture = {
      client_id = 1,
      client_secret = 2,
      discovery = "d",
      scope = "openid",
      response_type = "code",
      ssl_verify = "no",
      token_endpoint_auth_method = "client_secret_post",
      introspection_endpoint_auth_method = "client_secret_basic",
      filters = "pattern1,pattern2,pattern3",
      logout_path = "/logout",
      redirect_uri = "http://domain.com/auth/callback",
      redirect_after_logout_uri = "/login",
      prompt = "login",
      session = { cookie = { samesite = "None" } },
    }

    ngx = {
      var = { request_uri = "/path"},
      req = { get_uri_args = function() return nil end }
    }
end

function TestUtils:testOptions()
  local opts, session = utils.get_options(opts_fixture, ngx)

  local expectedFilters = {
    "pattern1",
    "pattern2",
    "pattern3"
  }

  lu.assertEquals(opts.client_id, 1)
  lu.assertEquals(opts.client_secret, 2)
  lu.assertEquals(opts.discovery, "d")
  lu.assertEquals(opts.scope, "openid")
  lu.assertEquals(opts.response_type, "code")
  lu.assertEquals(opts.ssl_verify, "no")
  lu.assertEquals(opts.token_endpoint_auth_method, "client_secret_post")
  lu.assertEquals(opts.introspection_endpoint_auth_method, "client_secret_basic")
  lu.assertItemsEquals(opts.filters, expectedFilters)
  lu.assertEquals(opts.logout_path, "/logout")
  lu.assertEquals(opts.redirect_uri, "http://domain.com/auth/callback")
  lu.assertEquals(opts.redirect_after_logout_uri, "/login")
  lu.assertEquals(opts.prompt, "login")
  lu.assertEquals(session.cookie.samesite, "None")

end

function TestUtils:testDiscoveryOverride()
  -- assign
  opts_fixture.discovery = nil
  opts_fixture.discovery_override = {
    authorization_endpoint = "https://localhost/auth/endpoint"
  }

  -- act
  local opts = utils.get_options(opts_fixture)

  -- assert
  lu.assertItemsEquals(opts.discovery, opts_fixture.discovery_override)
end

lu.run()
