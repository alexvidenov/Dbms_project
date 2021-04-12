defmodule DbmsProject3.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      DbmsProject3.Repo,
      # Start the Telemetry supervisor
      DbmsProject3Web.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: DbmsProject3.PubSub},
      # Start the Endpoint (http/https)
      DbmsProject3Web.Endpoint
      # Start a worker by calling: DbmsProject3.Worker.start_link(arg)
      # {DbmsProject3.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DbmsProject3.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DbmsProject3Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
