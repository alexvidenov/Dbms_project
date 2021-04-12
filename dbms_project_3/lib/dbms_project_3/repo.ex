defmodule DbmsProject3.Repo do
  use Ecto.Repo,
    otp_app: :dbms_project_3,
    adapter: Ecto.Adapters.Postgres
end
