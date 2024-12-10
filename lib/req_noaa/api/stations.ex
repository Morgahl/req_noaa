defmodule ReqNOAA.API.Stations do
  @moduledoc """
  NOAA Stations API
  """

  import ReqNOAA.API, only: [handle_response: 2]
  alias ReqNOAA.API

  @doc """
  Returns metadata about a given observation station

  ### Parameters

  - `station_id` (String.t): Observation station ID
  """
  @spec observation_station(String.t()) ::
          {:ok, ReqNOAA.Model.ObservationStationGeoJson.t()}
          | {:ok, ReqNOAA.Model.ObservationStationJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def observation_station(station_id) do
    API.new()
    |> Req.get(
      url: "/stations/:station_id",
      path_params: [station_id: station_id]
    )
    |> handle_response([
      {200, "application/geo+json", ReqNOAA.Model.ObservationStationGeoJson},
      {200, "application/ld+json", ReqNOAA.Model.ObservationStationJsonLd},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of observation stations.

  ### Options

    - `:id` ([String.t]): Filter by observation station ID
    - `:state` ([area_code]): Filter by state/marine area code
    - `:limit` (integer()): Limit
    - `:cursor` (String.t): Pagination cursor
  """
  @spec observation_stations(keyword()) ::
          {:ok, ReqNOAA.Model.ObservationStationGeoJson.t()}
          | {:ok, ReqNOAA.Model.ObservationStationJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def observation_stations(opts \\ []) do
    API.new()
    |> Req.get(
      url: "/stations",
      params: Keyword.take(opts, [:id, :state, :limit, :cursor])
    )
    |> handle_response([
      {200, "application/geo+json", ReqNOAA.Model.ObservationStationGeoJson},
      {200, "application/ld+json", ReqNOAA.Model.ObservationStationJsonLd},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns the latest observation for a station

  ### Parameters

  - `station_id` (String.t): Observation station ID

  ### Options

    - `:require_qc` (boolean()): Require QC
  """
  @spec observation_latest(String.t(), keyword()) ::
          {:ok, ReqNOAA.Model.ObservationGeoJson.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def observation_latest(station_id, opts \\ []) do
    API.new()
    |> Req.get(
      url: "/stations/:station_id/observations/latest",
      path_params: [station_id: station_id],
      params: Keyword.take(opts, [:require_qc])
    )
    |> handle_response([
      {200, ReqNOAA.Model.ObservationGeoJson},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of observations for a given station

  ### Parameters

  - `station_id` (String.t): Observation station ID

  ### Options

    - `:start` (DateTime.t): Start time
    - `:end` (DateTime.t): End time
    - `:limit` (integer()): Limit
  """
  @spec observation_list(String.t(), keyword()) ::
          {:ok, ReqNOAA.Model.ObservationCollectionGeoJson.t()}
          | {:ok, ReqNOAA.Model.ObservationCollectionJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def observation_list(station_id, opts \\ []) do
    API.new()
    |> Req.get(
      url: "/stations/:station_id/observations",
      path_params: [station_id: station_id],
      params: Keyword.take(opts, [:start, :end, :limit])
    )
    |> handle_response([
      {200, "application/geo+json", ReqNOAA.Model.ObservationCollectionGeoJson},
      {200, "application/ld+json", ReqNOAA.Model.ObservationCollectionJsonLd},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a single observation.

  ### Parameters

  - `station_id` (String.t): Observation station ID
  - `time` (DateTime.t): Timestamp of requested observation
  """
  @spec observation_time(String.t(), DateTime.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.ObservationGeoJson.t()} | {:error, any()}
  def observation_time(station_id, time) do
    API.new()
    |> Req.get(
      url: "/stations/:station_id/observations/:time",
      path_params: [station_id: station_id, time: time]
    )
    |> handle_response([
      {200, ReqNOAA.Model.ObservationGeoJson},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a single Terminal Aerodrome Forecast.

  ### Parameters

  - `station_id` (String.t): Observation station ID
  - `date` (Date.t): Date (YYYY-MM-DD format)
  - `time` (String.t): Time (HHMM format). This time is always specified in UTC (Zulu) time.
  """
  @spec taf(String.t(), Date.t(), String.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, any()} | {:error, any()}
  def taf(station_id, date, time) do
    API.new()
    |> Req.get(
      url: "/stations/:station_id/tafs/:date/:time",
      path_params: [station_id: station_id, date: date, time: time]
    )
    |> handle_response([
      {200, %{}},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns Terminal Aerodrome Forecasts for the specified airport station.

  ### Parameters

  - `station_id` (String.t): Observation station ID
  """
  @spec tafs(String.t()) :: {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, any()} | {:error, any()}
  def tafs(station_id) do
    API.new()
    |> Req.get(
      url: "/stations/:station_id/tafs",
      path_params: [station_id: station_id]
    )
    |> handle_response([
      {200, %{}},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end
end
