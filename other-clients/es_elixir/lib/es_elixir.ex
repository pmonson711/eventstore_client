defmodule EsElixir do
  @moduledoc """
  Documentation for `EsElixir`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> EsElixir.hello()
      :world

  """
  def hello do
    :world
  end

  def host, do: System.get_env("EVENTSTORE_HOST") || "localhost"
  def with_host(%URI{} = uri), do: with_host(uri, host())

  def with_host(%URI{} = uri, host) when is_binary(host) do
    %{uri | host: host}
  end

  def port, do: 2113
  def with_port(%URI{} = uri), do: with_port(uri, port())

  def with_port(%URI{} = uri, port) when is_integer(port) do
    %{uri | port: port}
  end

  def scheme, do: "https"
  def with_scheme(%URI{} = uri), do: with_scheme(uri, scheme())

  def with_scheme(%URI{} = uri, scheme) when is_binary(scheme) do
    %{uri | scheme: scheme}
  end

  def default, do: URI.new("#{scheme()}://#{host()}:#{port()}")

  def connect(%URI{} = uri),
    do: Spear.Connection.start_link(connection_string: URI.to_string(uri))

  def events, do: [Spear.Event.new("TestEvent", %{}), Spear.Event.new("TestEvent", %{})]

  def stream_name, do: "TestStream"

  def default_conn do
    with {:ok, uri} <- default(),
         {:ok, conn} <- connect(uri) do
      conn
    end
  end

  def run(conn), do: Spear.append(events(), conn, stream_name())
end
