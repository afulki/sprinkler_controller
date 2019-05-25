defmodule SprinklerControllerTest do
  use ExUnit.Case
  doctest SprinklerController

  test "greets the world" do
    assert SprinklerController.hello() == :world
  end
end
