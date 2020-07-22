defmodule ChatMultyNode.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    topologies = [
      chat: [
        strategy: Cluster.Strategy.Gossip
      ]
    ]

    children = [
      # Start the Ecto repository
      # ChatMultyNode.Repo,
      # Start the Telemetry supervisor
      ChatMultyNodeWeb.Telemetry,
      {Cluster.Supervisor, [topologies, [name: ChatMultyNode.ClusterSupervisor]]},
      # Start the PubSub system
      {Phoenix.PubSub, name: ChatMultyNode.PubSub, adapter: Phoenix.PubSub.PG2},
      # Start the Endpoint (http/https)
      ChatMultyNodeWeb.Endpoint,
      {Task, fn -> ping_nodes() end}
      # Start a worker by calling: ChatMultyNode.Worker.start_link(arg)
      # {ChatMultyNode.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ChatMultyNode.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp ping_nodes() do
    Process.sleep(1_000)
    Node.list()
    |> Enum.each(fn node ->
      IO.puts("[#{inspect(Node.self())} -> #{inspect(node)}] #{inspect(Node.ping(node))}")
    end)
    ping_nodes()
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ChatMultyNodeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
