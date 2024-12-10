defmodule ReqNOAA.API.Gridpoints do
  @moduledoc """
  NOAA Gridpoints API
  """

  import ReqNOAA.API, only: [handle_response: 2]
  alias ReqNOAA.API

  @typedoc "Forecast office ID"
  @type nws_forecast_office_id() :: String.t()

  @doc """
  Returns raw numerical forecast data for a 2.5km grid area

  ### Parameters

  - `wfo` (NwsForecastOfficeId): Forecast office ID
  - `x` (integer()): Forecast grid X coordinate
  - `y` (integer()): Forecast grid Y coordinate
  """
  @spec gridpoint(nws_forecast_office_id(), integer(), integer()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.GridpointGeoJson.t()} | {:error, any()}
  def gridpoint(wfo, x, y) do
    API.new()
    |> Req.get(
      url: "/gridpoints/:wfo/:x,:y",
      path_params: [wfo: wfo, x: x, y: y]
    )
    |> handle_response([
      {200, ReqNOAA.Model.GridpointGeoJson},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a textual forecast for a 2.5km grid area

  ### Parameters

  - `wfo` (NwsForecastOfficeId): Forecast office ID
  - `x` (integer()): Forecast grid X coordinate
  - `y` (integer()): Forecast grid Y coordinate

  ### Options

    - `:"Feature-Flags"` ([String.t]): Enable future and experimental features (see documentation for more info): * forecast_temperature_qv: Represent temperature as QuantitativeValue * forecast_wind_speed_qv: Represent wind speed as QuantitativeValue
    - `:units` (GridpointForecastUnits): Use US customary or SI (metric) units in textual output
  """
  @spec forecast(nws_forecast_office_id(), integer(), integer(), keyword()) ::
          {:ok, ReqNOAA.Model.GridpointForecastGeoJson.t()}
          | {:ok, ReqNOAA.Model.GridpointForecastJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def forecast(wfo, x, y, opts \\ []) do
    API.new()
    |> Req.get(
      url: "/gridpoints/:wfo/:x,:y/forecast",
      path_params: [wfo: wfo, x: x, y: y],
      params: Keyword.take(opts, [:units]),
      headers: Keyword.take(opts, [:"Feature-Flags"])
    )
    |> handle_response([
      {200, "application/geo+json", ReqNOAA.Model.GridpointForecastGeoJson},
      {200, "application/ld+json", ReqNOAA.Model.GridpointForecastJsonLd},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a textual hourly forecast for a 2.5km grid area

  ### Parameters

  - `wfo` (NwsForecastOfficeId): Forecast office ID
  - `x` (integer()): Forecast grid X coordinate
  - `y` (integer()): Forecast grid Y coordinate

  ### Options

    - `:"Feature-Flags"` ([String.t]): Enable future and experimental features (see documentation for more info): * forecast_temperature_qv: Represent temperature as QuantitativeValue * forecast_wind_speed_qv: Represent wind speed as QuantitativeValue
    - `:units` (GridpointForecastUnits): Use US customary or SI (metric) units in textual output
  """
  @spec forecast_hourly(nws_forecast_office_id(), integer(), integer(), keyword()) ::
          {:ok, ReqNOAA.Model.GridpointForecastGeoJson.t()}
          | {:ok, ReqNOAA.Model.GridpointForecastJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def forecast_hourly(wfo, x, y, opts \\ []) do
    API.new()
    |> Req.get(
      url: "/gridpoints/:wfo/:x,:y/forecast/hourly",
      path_params: [wfo: wfo, x: x, y: y],
      params: Keyword.take(opts, [:units]),
      headers: Keyword.take(opts, [:"Feature-Flags"])
    )
    |> handle_response([
      {200, "application/geo+json", ReqNOAA.Model.GridpointForecastGeoJson},
      {200, "application/ld+json", ReqNOAA.Model.GridpointForecastJsonLd},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of observation stations usable for a given 2.5km grid area

  ### Parameters

  - `wfo` (NwsForecastOfficeId): Forecast office ID
  - `x` (integer()): Forecast grid X coordinate
  - `y` (integer()): Forecast grid Y coordinate

  ### Options

    - `:limit` (integer()): Limit
    - `:cursor` (String.t): Pagination cursor
  """
  @spec stations(nws_forecast_office_id(), integer(), integer(), keyword()) ::
          {:ok, ReqNOAA.Model.ObservationStationCollectionGeoJson.t()}
          | {:ok, ReqNOAA.Model.ObservationStationCollectionJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def stations(wfo, x, y, opts \\ []) do
    API.new()
    |> Req.get(
      url: "/gridpoints/:wfo/:x,:y/stations",
      path_params: [wfo: wfo, x: x, y: y],
      params: Keyword.take(opts, [:limit, :cursor])
    )
    |> handle_response([
      {200, "application/geo+json", ReqNOAA.Model.ObservationStationCollectionGeoJson},
      {200, "application/ld+json", ReqNOAA.Model.ObservationStationCollectionJsonLd},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end
end
