defmodule ReqNOAA.API.Radar do
  @moduledoc """
  NOAA Radar API
  """

  import ReqNOAA.API, only: [handle_response: 2]
  alias ReqNOAA.API

  @doc """
  Returns metadata about a given radar wind profiler

  ### Parameters

  - `station_id` (String.t): Profiler station ID

  ### Options

    - `:time` (Iso8601Interval): Time interval
    - `:interval` (String.t): Averaging interval
  """
  @spec profiler(String.t(), keyword()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, any()} | {:error, any()}
  def profiler(station_id, opts \\ []) do
    API.new()
    |> Req.get(
      url: "/radar/profilers/:station_id",
      path_params: [station_id: station_id],
      params: Keyword.take(opts, [:time, :interval])
    )
    |> handle_response([
      {200, %{}},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns metadata about a given radar queue

  ### Parameters

  - `host` (String.t): LDM host

  ### Options

  - `:limit` (integer()): Record limit
  - `:arrived` (Iso8601Interval): Range for arrival time
  - `:created` (Iso8601Interval): Range for creation time
  - `:published` (Iso8601Interval): Range for publish time
  - `:station` (String.t): Station identifier
  - `:type` (String.t): Record type
  - `:feed` (String.t): Originating product feed
  - `:resolution` (integer()): Resolution version
  """
  @spec queue(String.t(), keyword()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, any()} | {:error, any()}
  def queue(host, opts \\ []) do
    API.new()
    |> Req.get(
      url: "/radar/queues/:host",
      path_params: [host: host],
      params: Keyword.take(opts, [:limit, :arrived, :created, :published, :station, :type, :feed, :resolution])
    )
    |> handle_response([
      {200, %{}},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns metadata about a given radar server

  ### Parameters

  - `id` (String.t): Server ID

  ### Options

  - `:reportingHost` (String.t): Show records from specific reporting host
  """
  @spec server(String.t(), keyword()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, any()} | {:error, any()}
  def server(id, opts \\ []) do
    API.new()
    |> Req.get(
      url: "/radar/servers/:id",
      path_params: [id: id],
      params: Keyword.take(opts, [:reportingHost])
    )
    |> handle_response([
      {200, %{}},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of radar servers

  ### Options

  - `:reportingHost` (String.t): Show records from specific reporting host
  """
  @spec servers(keyword()) :: {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, any()} | {:error, any()}
  def servers(opts \\ []) do
    API.new()
    |> Req.get(
      url: "/radar/servers",
      params: Keyword.take(opts, [:reportingHost])
    )
    |> handle_response([
      {200, %{}},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns metadata about a given radar station

  ### Parameters

  - `station_id` (String.t): Radar station ID

  ### Options

  - `:reportingHost` (String.t): Show RDA and latency info from specific reporting host
  - `:host` (String.t): Show latency info from specific LDM host
  """
  @spec station(String.t(), keyword()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, any()} | {:error, any()}
  def station(station_id, opts \\ []) do
    API.new()
    |> Req.get(
      url: "/radar/stations/:station_id",
      path_params: [station_id: station_id],
      params: Keyword.take(opts, [:reportingHost, :host])
    )
    |> handle_response([
      {200, %{}},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns metadata about a given radar station alarms

  ### Parameters

  - `station_id` (String.t): Radar station ID
  """
  @spec station_alarms(String.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, any()} | {:error, any()}
  def station_alarms(station_id) do
    API.new()
    |> Req.get(
      url: "/radar/stations/:station_id/alarms",
      path_params: [station_id: station_id]
    )
    |> handle_response([
      {200, %{}},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of radar stations

  ### Options

  - `:stationType` ([String.t]): Limit results to a specific station type or types
  - `:reportingHost` (String.t): Show RDA and latency info from specific reporting host
  - `:host` (String.t): Show latency info from specific LDM host
  """
  @spec stations(keyword()) :: {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, any()} | {:error, any()}
  def stations(opts \\ []) do
    API.new()
    |> Req.get(
      url: "/radar/stations",
      params: Keyword.take(opts, [:stationType, :reportingHost, :host])
    )
    |> handle_response([
      {200, %{}},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end
end
