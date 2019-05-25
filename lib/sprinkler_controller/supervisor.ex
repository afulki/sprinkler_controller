defmodule SprinklerController.Supervisor do
  use Supervisor
  # use Application

  def start(_, _) do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    Supervisor.init(children(), strategy: :one_for_one)
  end

  defp children() do
    [
      {SprinklerController, []},
      {ZoneControl, []},
      {Mqtt.Starter, []}
    ]
  end
end
