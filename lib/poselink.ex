defmodule Poselink do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    init()

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(Poselink.Repo, []),
      # Start the endpoint when the application starts
      supervisor(Poselink.Endpoint, []),
      # Start the Trigger and Action
      supervisor(Poselink.TriggerSupervisor, []),
      supervisor(Poselink.ActionSupervisor, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Poselink.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Poselink.Endpoint.config_change(changed, removed)
    :ok
  end

  def init do
    HTTPoison.start

    :ok
  end
end
