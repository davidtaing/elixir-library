defmodule Library.Repo do
  use AshPostgres.Repo,
    otp_app: :library

  def installed_extensions do
    # Add extensions here, and the migration generator will install them.
    ["ash-functions", "uuid-ossp", "citext"]
  end
end
