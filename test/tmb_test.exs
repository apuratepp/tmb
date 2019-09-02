defmodule TmbTest do
  use ExUnit.Case
  doctest Tmb

  test "greets the world" do
    assert Tmb.hello() == :world
  end
end
