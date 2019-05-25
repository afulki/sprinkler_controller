defmodule ZoneControl do
  use GenServer

  require Logger

  def start_link(_init_args) do
    GenServer.start_link(__MODULE__, I2cControl.new(), name: __MODULE__)
  end

  def init(state) do
    {:ok, I2cControl.init_i2c(state)}
  end

  def set("ON", zone_info) do
    Logger.info("ZoneControl -> ON: #{inspect(zone_info)}")
    GenServer.cast(__MODULE__, {:on, zone_info})
  end

  def set("OFF", zone_info) do
    Logger.info("ZoneControl -> OFF: #{inspect(zone_info)}")
    GenServer.cast(__MODULE__, {:off, zone_info})
  end

  def handle_cast({pin_state, zone_info}, state) do
    Logger.info("ZoneControl::cast -> #{pin_state}, #{inspect(zone_info)}")
    {:noreply, I2cControl.write_to_pin(state, zone_info, pin_state)}
  end
end
