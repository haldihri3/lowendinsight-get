use Mix.Config

config :lowendinsight_get, LowendinsightGet.Endpoint,
  port: String.to_integer(System.get_env("PORT") || "4444")

config :lowendinsight,
 ## Contributor in terms of discrete users
  ## NOTE: this currently doesn't discern same user with different email
  critical_contributor_level: String.to_integer(System.get_env("LEI_CRITICAL_CONTRIBUTOR_LEVEL") || "2"),
  high_contributor_level: String.to_integer(System.get_env("LEI_HIGH_CONTRIBUTOR_LEVEL") || "3"),
  medium_contributor_level: String.to_integer(System.get_env("LEI_CRITICAL_CONTRIBUTOR_LEVEL") || "5"),

  ## Commit currency in weeks - is the project active.  This by itself
  ## may not indicate anything other than the repo is stable. The reason
  ## we're reporting it is relative to the likelihood vulnerabilities
  ## getting fix in a timely manner
  critical_currency_level: String.to_integer(System.get_env("LEI_CRITICAL_CURRENCY_LEVEL") || "104"),
  high_currency_level: String.to_integer(System.get_env("LEI_HIGH_CURRENCY_LEVEL") || "52"),
  medium_currency_level: String.to_integer(System.get_env("LEI_MEDIUM_CURRENCY_LEVEL") || "26"),

  ## Percentage of changes to repo in recent commit - is the codebase
  ## volatile in terms of quantity of source being changed
  critical_large_commit_level: String.to_float(System.get_env("LEI_CRITICAL_LARGE_COMMIT_LEVEL") || "0.30"),
  high_large_commit_level: String.to_float(System.get_env("LEI_HIGH_LARGE_COMMIT_LEVEL") || "0.15"),
  medium_large_commit_level: String.to_float(System.get_env("LEI_MEDIUM_LARGE_COMMIT_LEVEL") || "0.05"),

  ## Bell curve contributions - if there are 30 contributors
  ## but 90% of the contributions are from 2...
  critical_functional_contributors_level: String.to_integer(System.get_env("LEI_CRITICAL_FUNCTIONAL_CONTRIBUTORS_LEVEL") || "2"),
  high_functional_contributors_level: String.to_integer(System.get_env("LEI_HIGH_FUNCTIONAL_CONTRIBUTORS_LEVEL") || "3"),
  medium_functional_contributors_level: String.to_integer(System.get_env("LEI_MEDIUM_FUNCTIONAL_CONTRIBUTORS_LEVEL") || "5")

config :redix,
  server: System.get_env("REDIS_HOST") || "localhost",
  port: String.to_integer(System.get_env("REDIS_PORT") || "6379"),
  db: String.to_integer(System.get_env("REDIS_DB") || "3")
