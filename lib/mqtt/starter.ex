defmodule Mqtt.Starter do
  use GenServer

  require Logger

  def start_link(_args) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    Process.send_after(__MODULE__, :subscribe, 10_000, [])

    {:ok, %{}}
  end

  def handle_info(:subscribe, state) do
    Logger.info(
      "================================= Subscribing =================================="
    )

    Tortoise.Supervisor.start_child(
      client_id: "nerves_sprinkler_controller",
      handler: {Mqtt.Processor, []},
      server: {Tortoise.Transport.Tcp, host: '10.0.1.200', port: 1883},
      subscriptions: [{"home/sprinkler/cmd/#", 0}]
    )

    Tortoise.Supervisor.start_child(
      client_id: "nerves_sprinkler_controller_status",
      handler: {Mqtt.Processor, []},
      server: {Tortoise.Transport.Tcp, host: '10.0.1.200', port: 1883},
      subscriptions: [{"home/sprinkler/stat", 0}]
    )

    {:noreply, state}
  end
end
