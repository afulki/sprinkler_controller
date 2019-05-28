defmodule I2cControl do
  require Logger

  # %{board_address: 16, board_pin: 4}
  defstruct i2c_pid: nil, pin_state: []

  alias Circuits.I2C

  def new() do
    %__MODULE__{}
  end

  def connected?(%__MODULE__{} = state) do
    state.i2c_pid != nil
  end

  def init_i2c(state) do
    state
    |> connect_to_bus()
  end

  def write_to_pin(state, zone_info, :on) do
    Logger.info("I2cControl::write_to_pin -> on")
    _write_to_pin(state, zone_info, 0xFF)
  end

  def write_to_pin(state, zone_info, :off) do
    Logger.info("I2cControl::write_to_pin -> off")
    _write_to_pin(state, zone_info, 0x00)
  end

  defp _write_to_pin(state, zone_info, pin_val) do
    Logger.info("I2cControl::_write_to_pin -> #{pin_val}")

    state =
      case connected?(state) do
        true -> state
        _ -> init_i2c(state)
      end

    Logger.info("I2cControl::_write_to_pin -> #{inspect(state)}")

    case connected?(state) do
      true ->
        Logger.info("I2cControl -> connected #{inspect(state)}")
        I2C.write(state.i2c_pid, zone_info.board_address, <<zone_info.board_pin, pin_val>>)

      _ ->
        Logger.error("I2C -> Not connected!")
    end

    state
  end

  defp connect_to_bus(state) do
    case I2C.open("i2c-1") do
      {:ok, pid} ->
        %{state | i2c_pid: pid}

      {:error, reason} ->
        Logger.error("I2C -> #{reason}")
        state

      _ ->
        state
    end
  end

  # defp enumerate_bus(state) do
  #   case state.i2c_pid do
  #     nil ->
  #       state

  #     _pid ->
  #       boards = I2C.detect_devices()
  #       %{state | boards: boards}
  #   end
  # end
end
