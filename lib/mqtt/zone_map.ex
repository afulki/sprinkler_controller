defmodule ZoneMap do
  def map("1"), do: {:ok, %{board_address: 16, board_pin: 1}}
  def map("2"), do: {:ok, %{board_address: 16, board_pin: 2}}
  def map("3"), do: {:ok, %{board_address: 16, board_pin: 3}}
  def map("4"), do: {:ok, %{board_address: 16, board_pin: 4}}
  def map("5"), do: {:ok, %{board_address: 17, board_pin: 1}}
  def map("6"), do: {:ok, %{board_address: 17, board_pin: 2}}
  def map("7"), do: {:ok, %{board_address: 17, board_pin: 3}}
  def map("8"), do: {:ok, %{board_address: 17, board_pin: 4}}
  def map("9"), do: {:ok, %{board_address: 18, board_pin: 1}}
  def map("10"), do: {:ok, %{board_address: 18, board_pin: 2}}
  def map("11"), do: {:ok, %{board_address: 18, board_pin: 3}}
  def map("12"), do: {:ok, %{board_address: 18, board_pin: 4}}
  def map(_), do: {:error, "Unknown Zone"}
end
