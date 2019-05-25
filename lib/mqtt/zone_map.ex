defmodule ZoneMap do
  def map("homesprinkler1"), do: {:ok, %{board_address: 16, board_pin: 1}}
  def map("homesprinkler2"), do: {:ok, %{board_address: 16, board_pin: 2}}
  def map("homesprinkler3"), do: {:ok, %{board_address: 16, board_pin: 3}}
  def map("homesprinkler4"), do: {:ok, %{board_address: 16, board_pin: 4}}
  def map("homesprinkler5"), do: {:ok, %{board_address: 17, board_pin: 1}}
  def map("homesprinkler6"), do: {:ok, %{board_address: 17, board_pin: 2}}
  def map("homesprinkler7"), do: {:ok, %{board_address: 17, board_pin: 3}}
  def map("homesprinkler8"), do: {:ok, %{board_address: 17, board_pin: 4}}
  def map("homesprinkler9"), do: {:ok, %{board_address: 18, board_pin: 1}}
  def map("homesprinkler10"), do: {:ok, %{board_address: 18, board_pin: 2}}
  def map("homesprinkler11"), do: {:ok, %{board_address: 18, board_pin: 3}}
  def map("homesprinkler12"), do: {:ok, %{board_address: 18, board_pin: 4}}
  def map(_), do: {:error, "Unknown Zone"}
end
