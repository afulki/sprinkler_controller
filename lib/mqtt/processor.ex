defmodule Mqtt.Processor do
  use Tortoise.Handler

  require Logger

  def init(args) do
    {:ok, args}
  end

  def connection(_status, state) do
    # `status` will be either `:up` or `:down`; you can use this to
    # inform the rest of your system if the connection is currently
    # open or closed; tortoise should be busy reconnecting if you get
    # a `:down`
    {:ok, state}
  end

  @doc """
  Callback to handle retrieving the state

  payload: not used
  """
  def handle_message(["home", "sprinkler", "stat"], _payload, state) do
    Logger.info("Received stat message")

    {:ok, state}
  end

  @doc """
  Callback to handle command messages, will switch the assocaited relay on or off

  payload: "ON" or "OFF"
  """
  def handle_message(["home", "sprinkler", "cmd", zone], payload, state) do
    case ZoneMap.map(zone) do
      {:ok, zone_info} ->
        Logger.info(
          "Recieved #{inspect(payload)} for zone: #{zone}, mapped to: #{inspect(zone_info)}"
        )

        ZoneControl.set(payload, zone_info)

      {:error, reason} ->
        Logger.error("zone: #{zone} resulted in: #{reason}")
    end

    {:ok, state}
  end

  def handle_message(topic, _, state) do
    Logger.error("Unknown topic : #{inspect(topic)}")
    {:ok, state}
  end

  def subscription(status, topic_filter, state) do
    Logger.info("Topic #{topic_filter} -> #{status}")
    {:ok, state}
  end

  def terminate(_reason, _state) do
    # tortoise doesn't care about what you return from terminate/2,
    # that is in alignment with other behaviours that implement a
    # terminate-callback
    :ok
  end
end
