defmodule ElixirInActionTest do
  use ExUnit.Case
  doctest ElixirInAction

  test "greets the world" do
    assert ElixirInAction.hello() == :world
  end
end
