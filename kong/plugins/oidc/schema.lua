local typedefs = require "kong.db.schema.typedefs"

return {
  name = "kong-oidc",
  fields = {
    { consumer = typedefs.no_consumer },
    {
      config = {
        type = "record",
        fields = {
          { client_id = { type = "string", required = true } },
          { client_secret = { type = "string", required = true } },
          { discovery = { type = "string", required = true, default = "https://.well-known/openid-configuration" } },
          { introspection_endpoint = { type = "string", required = false } },
          { timeout = { type = "number", required = false } },
          { introspection_endpoint_auth_method = { type = "string", required = false } },
          { bearer_only = { type = "string", required = true, default = "no" } },
          { realm = { type = "string", required = true, default = "kong" } },
          { redirect_uri = { type = "string", required = false } },
          { redirect_uri_scheme = { type = "string", required = false } },
          { redirect_uri_path = { type = "string", required = false } },
          { scope = { type = "string", required = true, default = "openid" } },
          { prompt = { type = "string", required = false } },
          { response_type = { type = "string", required = true, default = "code" } },
          { ssl_verify = { type = "string", required = true, default = "no" } },
          { token_endpoint_auth_method = { type = "string", required = true, default = "client_secret_post" } },
          { session_secret = { type = "string", required = false } },
          { recovery_page_path = { type = "string" } },
          { logout_path = { type = "string", required = false, default = '/logout' } },
          { redirect_after_logout_uri = { type = "string", required = false, default = '/' } },
          { filters = { type = "string" } },
          { session = {
              type = "record",
              required = false,
              fields = {
                { cookie = {
                    type = "record",
                    required = false,
                    fields = {
                      { samesite = { type = "string", required = false, default = "Lax" } },
                      { secure = { type = "boolean", default = true } }
                    }
                  }
                },
                { secret = { type = "string", required = false } }
              }
            }
          },
          { discovery_override = {
              type = "record",
              required = false,
              fields = {
                { authorization_endpoint = { type = "string", required = false } },
                { token_endpoint = { type = "string", required = false } },
                { userinfo_endpoint = { type = "string", required = false } },
                { jwks_uri = { type = "string", required = false } },
                { revocation_endpoint = { type = "string", required = false } },
                { issuer = { type = "string", required = false } },
                { introspection_endpoint = { type = "string", required = false } },
                { end_session_endpoint = { type = "string", required = false  } }
              }
            }
          }
        }
      }
    }
  }
}
