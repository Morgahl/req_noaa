defmodule ReqNOAA.API.Zones do
  @moduledoc """
  NOAA Zones API
  """

  import ReqNOAA.API, only: [handle_response: 2]
  alias ReqNOAA.API

  @typedoc "Zone type"
  @type nws_zone_type() :: String.t()

  @doc """
  Returns metadata about a given zone

  ### Parameters

  - `type` (nws_zone_type): Zone type
  - `zone_id` (String.t): NWS public zone/county identifier

  ### Options

    - `:effective` (DateTime.t): Effective date/time
  """
  @spec zone(nws_zone_type(), String.t(), keyword()) ::
          {:ok, ReqNOAA.Model.ZoneGeoJson.t()} | {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:error, any()}
  def zone(type, zone_id, opts \\ []) do
    API.new()
    |> Req.get(
      url: "/zones/:type/:zone_id",
      path_params: [type: type, zone_id: zone_id],
      params: Keyword.take(opts, [:effective])
    )
    |> handle_response([
      {200, ReqNOAA.Model.ZoneGeoJson},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns the current zone forecast for a given zone

  ### Parameters

  - `type` (String.t): Zone type
  - `zone_id` (String.t): NWS public zone/county identifier
  """
  @spec forecast(String.t(), String.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.ZoneForecastGeoJson.t()} | {:error, any()}
  def forecast(type, zone_id) do
    API.new()
    |> Req.get(
      url: "/zones/:type/:zone_id/forecast",
      path_params: [type: type, zone_id: zone_id]
    )
    |> handle_response([
      {200, ReqNOAA.Model.ZoneForecastGeoJson},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of zones

  ### Options

    - `:id` ([String.t]): Zone ID (forecast or county)
    - `:area` ([area_code]): State/marine area code
    - `:region` ([ReqNOAA.Model.RegionCode.t]): Region code
    - `:type` ([nws_zone_type]): Zone type
    - `:point` (String.t): Point (latitude,longitude)
    - `:include_geometry` (boolean()): Include geometry in results (true/false)
    - `:limit` (integer()): Limit
    - `:effective` (DateTime.t): Effective date/time
  """
  @spec list(keyword()) ::
          {:ok, ReqNOAA.Model.ZoneCollectionGeoJson.t()} | {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:error, any()}
  def list(opts \\ []) do
    API.new()
    |> Req.get(
      url: "/zones",
      params: Keyword.take(opts, [:id, :area, :region, :type, :point, :include_geometry, :limit, :effective])
    )
    |> handle_response([
      {200, ReqNOAA.Model.ZoneCollectionGeoJson},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of zones of a given type

  ### Parameters

    - `type` (nws_zone_type): Zone type

  ### Options

    - `:id` ([String.t]): Zone ID (forecast or county)
    - `:area` ([area_code]): State/marine area code
    - `:region` ([ReqNOAA.Model.RegionCode.t]): Region code
    - `:type` ([nws_zone_type]): Zone type
    - `:point` (String.t): Point (latitude,longitude)
    - `:include_geometry` (boolean()): Include geometry in results (true/false)
    - `:limit` (integer()): Limit
    - `:effective` (DateTime.t): Effective date/time
  """
  @spec list_type(nws_zone_type()) ::
          {:ok, ReqNOAA.Model.ZoneCollectionGeoJson.t()} | {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:error, any()}
  def list_type(type, opts \\ []) do
    API.new()
    |> Req.get(
      url: "/zones/:type",
      path_params: [type: type],
      params: Keyword.take(opts, [:id, :area, :region, :type, :point, :include_geometry, :limit, :effective])
    )
    |> handle_response([
      {200, ReqNOAA.Model.ZoneCollectionGeoJson},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of observations for a given zone

  ### Parameters

  - `zone_id` (String.t): NWS public zone/county identifier

  ### Options

    - `:start` (DateTime.t): Start date/time
    - `:end` (DateTime.t): End date/time
    - `:limit` (integer()): Limit
  """
  @spec obs(String.t(), keyword()) ::
          {:ok, ReqNOAA.Model.ObservationCollectionGeoJson.t()}
          | {:ok, ReqNOAA.Model.ObservationCollectionJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def obs(zone_id, opts \\ []) do
    API.new()
    |> Req.get(
      url: "/zones/forecast/:zone_id/observations",
      path_params: [zone_id: zone_id],
      params: Keyword.take(opts, [:start, :end, :limit])
    )
    |> handle_response([
      {200, "application/geo+json", ReqNOAA.Model.ObservationCollectionGeoJson},
      {200, "application/ld+json", ReqNOAA.Model.ObservationCollectionJsonLd},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of observation stations for a given zone

  ### Parameters

  - `zone_id` (String.t): NWS public zone/county identifier

  ### Options

    - `:limit` (integer()): Limit
    - `:cursor` (String.t): Pagination cursor
  """
  @spec stations(String.t(), keyword()) ::
          {:ok, ReqNOAA.Model.ObservationStationCollectionGeoJson.t()}
          | {:ok, ReqNOAA.Model.ObservationStationCollectionJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def stations(zone_id, opts \\ []) do
    API.new()
    |> Req.get(
      url: "/zones/forecast/:zone_id/stations",
      path_params: [zone_id: zone_id],
      params: Keyword.take(opts, [:limit, :cursor])
    )
    |> handle_response([
      {200, "application/geo+json", ReqNOAA.Model.ObservationStationCollectionGeoJson},
      {200, "application/ld+json", ReqNOAA.Model.ObservationStationCollectionJsonLd},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of forecasts for a given zone

  ### Parameters

  - `zone_id` (String.t): NWS public zone/county identifier
  """
  @spec forecast(String.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.ZoneGeoJson.t()} | {:error, any()}
  def forecast(zone_id) do
    API.new()
    |> Req.get(
      url: "/zones/forecast/:zone_id",
      path_params: [zone_id: zone_id]
    )
    |> handle_response([
      {200, ReqNOAA.Model.ZoneGeoJson},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end
end
