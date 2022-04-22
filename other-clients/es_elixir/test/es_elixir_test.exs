defmodule EsElixirTest do
  use ExUnit.Case
  doctest EsElixir

  test "greets the world" do
    assert EsElixir.hello() == :world
  end
end
