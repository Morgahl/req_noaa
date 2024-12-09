defmodule ReqNOAA.Api do
  @moduledoc """
  Module to request data from NOAA API
  """

  alias Req.Response

  @typedoc "State/territory code or marine area code"
  @type area_code :: String.t() | marine_region_code()

  @typedoc "Marine region code"
  @type marine_region_code() :: String.t()

  @typedoc """
  Alert urgency

  - `"immediate"`: Immediate
  - `"expected"`: Expected
  - `"future"`: Future
  - `"past"`: Past
  - `"unknown"`: Unknown
  """
  @type alert_urgency() :: String.t()

  @typedoc """
  Alert severity

  - `"extreme"`: Extreme
  - `"severe"`: Severe
  - `"moderate"`: Moderate
  - `"minor"`: Minor
  - `"unknown"`: Unknown
  """
  @type alert_severity() :: String.t()

  @typedoc """
  Alert certainty

  - `"observed"`: Observed
  - `"likely"`: Likely
  - `"possible"`: Possible
  - `"unlikely"`: Unlikely
  - `"unknown"`: Unknown
  """
  @type alert_certainty() :: String.t()

  @typedoc "Forecast office ID"
  @type nws_forecast_office_id() :: String.t()

  @typedoc "Zone type"
  @type nws_zone_type() :: String.t()

  @doc """
  Returns all currently active alerts

  ### Options

    - `:status` ([String.t]): Status (actual, exercise, system, test, draft)
    - `:message_type` ([String.t]): Message type (alert, update, cancel)
    - `:event` ([String.t]): Event name
    - `:code` ([String.t]): Event code
    - `:area` ([area_code]): State/territory code or marine area code This parameter is incompatible with the following parameters: point, region, region_type, zone
    - `:point` (String.t): Point (latitude,longitude) This parameter is incompatible with the following parameters: area, region, region_type, zone
    - `:region` ([marine_region_code]): Marine region code This parameter is incompatible with the following parameters: area, point, region_type, zone
    - `:region_type` (String.t): Region type (land or marine) This parameter is incompatible with the following parameters: area, point, region, zone
    - `:zone` ([String.t]): Zone ID (forecast or county) This parameter is incompatible with the following parameters: area, point, region, region_type
    - `:urgency` ([alert_urgency]): Urgency (immediate, expected, future, past, unknown)
    - `:severity` ([alert_severity]): Severity (extreme, severe, moderate, minor, unknown)
    - `:certainty` ([alert_certainty]): Certainty (observed, likely, possible, unlikely, unknown)
    - `:limit` (integer()): Limit
  """
  @spec alerts_active(keyword()) ::
          {:ok, nil}
          | {:ok, ReqNOAA.Model.AlertCollectionGeoJson.t()}
          | {:ok, ReqNOAA.Model.AlertCollectionJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def alerts_active(opts \\ []) do
    optional_params = [
      :status,
      :message_type,
      :event,
      :code,
      :area,
      :point,
      :region,
      :region_type,
      :zone,
      :urgency,
      :severity,
      :certainty,
      :limit
    ]

    ReqNOAA.new()
    |> Req.get(
      url: "/alerts/active",
      params: Keyword.take(opts, optional_params)
    )
    |> handle_response([
      {200, "application/geo+json", ReqNOAA.Model.AlertCollectionGeoJson},
      {200, "application/ld+json", ReqNOAA.Model.AlertCollectionJsonLd},
      {301, %{}},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns active alerts for the given area (state or marine area)

  ### Parameters

  - `area` (area_code): State/area ID
  """
  @spec alerts_active_area(area_code()) ::
          {:ok, ReqNOAA.Model.AlertCollectionGeoJson.t()}
          | {:ok, ReqNOAA.Model.AlertCollectionJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def alerts_active_area(area) do
    ReqNOAA.new()
    |> Req.get(
      url: "/alerts/active/area/:area",
      path_params: [area: area]
    )
    |> handle_response([
      {200, "application/geo+json", ReqNOAA.Model.AlertCollectionGeoJson},
      {200, "application/ld+json", ReqNOAA.Model.AlertCollectionJsonLd},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns info on the number of active alerts
  """
  @spec alerts_active_count() ::
          {:ok, ReqNOAA.Model.AlertsActiveCountResponse.t()} | {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:error, any()}
  def alerts_active_count do
    ReqNOAA.new()
    |> Req.get(url: "/alerts/active/count")
    |> handle_response([
      {200, ReqNOAA.Model.AlertsActiveCountResponse},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns active alerts for the given marine region

  ### Parameters

  - `region` (MarineRegionCode): Marine region ID
  """
  @spec alerts_active_region(ReqNOAA.Model.MarineRegionCode.t()) ::
          {:ok, ReqNOAA.Model.AlertCollectionGeoJson.t()}
          | {:ok, ReqNOAA.Model.AlertCollectionJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def alerts_active_region(region) do
    ReqNOAA.new()
    |> Req.get(
      url: "/alerts/active/region/:region",
      path_params: [region: region]
    )
    |> handle_response([
      {200, "application/geo+json", ReqNOAA.Model.AlertCollectionGeoJson},
      {200, "application/ld+json", ReqNOAA.Model.AlertCollectionJsonLd},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns active alerts for the given NWS public zone or county

  ### Parameters

  - `zone_id` (String.t): NWS public zone/county identifier
  """
  @spec alerts_active_zone(String.t()) ::
          {:ok, ReqNOAA.Model.AlertCollectionGeoJson.t()}
          | {:ok, ReqNOAA.Model.AlertCollectionJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def alerts_active_zone(zone_id) do
    ReqNOAA.new()
    |> Req.get(
      url: "/alerts/active/zone/:zone_id",
      path_params: [zone_id: zone_id]
    )
    |> handle_response([
      {200, "application/geo+json", ReqNOAA.Model.AlertCollectionGeoJson},
      {200, "application/ld+json", ReqNOAA.Model.AlertCollectionJsonLd},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns all alerts

  ### Options

    - `:active` (boolean()): List only active alerts (use /alerts/active endpoints instead)
    - `:start` (DateTime.t): Start time
    - `:end` (DateTime.t): End time
    - `:status` ([String.t]): Status (actual, exercise, system, test, draft)
    - `:message_type` ([String.t]): Message type (alert, update, cancel)
    - `:event` ([String.t]): Event name
    - `:code` ([String.t]): Event code
    - `:area` ([area_code]): State/territory code or marine area code This parameter is incompatible with the following parameters: point, region, region_type, zone
    - `:point` (String.t): Point (latitude,longitude) This parameter is incompatible with the following parameters: area, region, region_type, zone
    - `:region` ([ReqNOAA.Model.MarineRegionCode.t]): Marine region code This parameter is incompatible with the following parameters: area, point, region_type, zone
    - `:region_type` (String.t): Region type (land or marine) This parameter is incompatible with the following parameters: area, point, region, zone
    - `:zone` ([String.t]): Zone ID (forecast or county) This parameter is incompatible with the following parameters: area, point, region, region_type
    - `:urgency` ([alert_urgency]): Urgency (immediate, expected, future, past, unknown)
    - `:severity` ([alert_severity]): Severity (extreme, severe, moderate, minor, unknown)
    - `:certainty` ([alert_certainty]): Certainty (observed, likely, possible, unlikely, unknown)
    - `:limit` (integer()): Limit
    - `:cursor` (String.t): Pagination cursor
  """
  @spec alerts_query(keyword()) ::
          {:ok, nil}
          | {:ok, ReqNOAA.Model.AlertCollectionGeoJson.t()}
          | {:ok, ReqNOAA.Model.AlertCollectionJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def alerts_query(opts \\ []) do
    optional_params = [
      :active,
      :start,
      :end,
      :status,
      :message_type,
      :event,
      :code,
      :area,
      :point,
      :region,
      :region_type,
      :zone,
      :urgency,
      :severity,
      :certainty,
      :limit,
      :cursor
    ]

    ReqNOAA.new()
    |> Req.get(
      url: "/alerts",
      params: Keyword.take(opts, optional_params)
    )
    |> handle_response([
      {200, "application/geo+json", ReqNOAA.Model.AlertCollectionGeoJson},
      {200, "application/ld+json", ReqNOAA.Model.AlertCollectionJsonLd},
      {301, %{}},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a specific alert

  ### Parameters

  - `id` (String.t): Alert identifier
  """
  @spec alerts_single(String.t()) ::
          {:ok, ReqNOAA.Model.AlertGeoJson.t()}
          | {:ok, ReqNOAA.Model.AlertJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def alerts_single(id) do
    ReqNOAA.new()
    |> Req.get(
      url: "/alerts/:id",
      path_params: [id: id]
    )
    |> handle_response([
      {200, "application/geo+json", ReqNOAA.Model.AlertGeoJson},
      {200, "application/ld+json", ReqNOAA.Model.AlertJsonLd},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of alert types
  """
  @spec alerts_types() ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.AlertsTypesResponse.t()} | {:error, any()}
  def alerts_types do
    ReqNOAA.new()
    |> Req.get(url: "/alerts/types")
    |> handle_response([
      {200, ReqNOAA.Model.AlertsTypesResponse},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of Center Weather Advisories from a CWSU

  ### Parameters

  - `cwsu_id` (NwsCenterWeatherServiceUnitId): NWS CWSU ID
  - `date` (Date.t): Date (YYYY-MM-DD format)
  - `sequence` (integer()): Sequence number
  """
  @spec cwa(ReqNOAA.Model.NwsCenterWeatherServiceUnitId.t(), Date.t(), integer()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.CenterWeatherAdvisoryGeoJson.t()} | {:error, any()}
  def cwa(cwsu_id, date, sequence) do
    ReqNOAA.new()
    |> Req.get(
      url: "/aviation/cwsus/:cwsu_id/cwas/:date/:sequence",
      path_params: [
        cwsu_id: cwsu_id,
        date: date,
        sequence: sequence
      ]
    )
    |> handle_response([
      {200, ReqNOAA.Model.CenterWeatherAdvisoryGeoJson},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of Center Weather Advisories from a CWSU

  ### Parameters

  - `cwsu_id` (NwsCenterWeatherServiceUnitId): NWS CWSU ID
  """
  @spec cwas(ReqNOAA.Model.NwsCenterWeatherServiceUnitId.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.CenterWeatherAdvisoryCollectionGeoJson.t()} | {:error, any()}
  def cwas(cwsu_id) do
    ReqNOAA.new()
    |> Req.get(
      url: "/aviation/cwsus/:cwsu_id/cwas",
      path_params: [cwsu_id: cwsu_id]
    )
    |> handle_response([
      {200, ReqNOAA.Model.CenterWeatherAdvisoryCollectionGeoJson},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns metadata about a Center Weather Service Unit

  ### Parameters

  - `cwsu_id` (NwsCenterWeatherServiceUnitId): NWS CWSU ID
  """
  @spec cwsu(ReqNOAA.Model.NwsCenterWeatherServiceUnitId.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.Office.t()} | {:error, any()}
  def cwsu(cwsu_id) do
    ReqNOAA.new()
    |> Req.get(
      url: "/aviation/cwsus/:cwsu_id",
      path_params: [cwsu_id: cwsu_id]
    )
    |> handle_response([
      {200, ReqNOAA.Model.Office},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns glossary terms
  """
  @spec glossary() ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.GlossaryResponse.t()} | {:error, any()}
  def glossary() do
    ReqNOAA.new()
    |> Req.get(url: "/glossary")
    |> handle_response([
      {200, ReqNOAA.Model.GlossaryResponse},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

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
    ReqNOAA.new()
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
  @spec gridpoint_forecast(nws_forecast_office_id(), integer(), integer(), keyword()) ::
          {:ok, ReqNOAA.Model.GridpointForecastGeoJson.t()}
          | {:ok, ReqNOAA.Model.GridpointForecastJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def gridpoint_forecast(wfo, x, y, opts \\ []) do
    ReqNOAA.new()
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
  @spec gridpoint_forecast_hourly(nws_forecast_office_id(), integer(), integer(), keyword()) ::
          {:ok, ReqNOAA.Model.GridpointForecastGeoJson.t()}
          | {:ok, ReqNOAA.Model.GridpointForecastJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def gridpoint_forecast_hourly(wfo, x, y, opts \\ []) do
    ReqNOAA.new()
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
  @spec gridpoint_stations(nws_forecast_office_id(), integer(), integer(), keyword()) ::
          {:ok, ReqNOAA.Model.ObservationStationCollectionGeoJson.t()}
          | {:ok, ReqNOAA.Model.ObservationStationCollectionJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def gridpoint_stations(wfo, x, y, opts \\ []) do
    ReqNOAA.new()
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

  @doc """
  Returns a forecast icon. Icon services in API are deprecated.

  ### Parameters

  - `set` (String.t): .
  - `time_of_day` (String.t): .
  - `first` (String.t): .

  ### Options

    - `:size` (IconsSizeParameter): Font size
    - `:fontsize` (integer()): Font size
  """
  @spec icons(String.t(), String.t(), String.t(), keyword()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, String.t()} | {:error, any()}
  def icons(set, time_of_day, first, opts \\ []) do
    ReqNOAA.new()
    |> Req.get(
      url: "/icons/:set/:time_of_day/:first",
      params: Keyword.take(opts, [:size, :fontsize]),
      path_params: [
        set: set,
        time_of_day: time_of_day,
        first: first
      ]
    )
    |> handle_response([
      {200, %{}},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a forecast icon. Icon services in API are deprecated.

  ### Parameters

  - `set` (String.t): .
  - `time_of_day` (String.t): .
  - `first` (String.t): .
  - `second` (String.t): .

  ### Options

    - `:size` (IconsSizeParameter): Font size
    - `:fontsize` (integer()): Font size
  """
  @spec icons_dual_condition(String.t(), String.t(), String.t(), String.t(), keyword()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, String.t()} | {:error, any()}
  def icons_dual_condition(set, time_of_day, first, second, opts \\ []) do
    ReqNOAA.new()
    |> Req.get(
      url: "/icons/:set/:time_of_day/:first/:second",
      params: Keyword.take(opts, [:size, :fontsize]),
      path_params: [
        set: set,
        time_of_day: time_of_day,
        first: first,
        second: second
      ]
    )
    |> handle_response([
      {200, %{}},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of icon codes and textual descriptions. Icon services in API are deprecated.
  """
  @spec icons_summary() ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.IconsSummaryResponse.t()} | {:error, any()}
  def icons_summary do
    ReqNOAA.new()
    |> Req.get(url: "/icons")
    |> handle_response([
      {200, ReqNOAA.Model.IconsSummaryResponse},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of valid text product types for a given issuance location

  ### Parameters

  - `location_id` (String.t): .
  """
  @spec location_products(String.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.TextProductTypeCollection.t()} | {:error, any()}
  def location_products(location_id) do
    ReqNOAA.new()
    |> Req.get(
      url: "/products/locations/:location_id/types",
      path_params: [location_id: location_id]
    )
    |> handle_response([
      {200, ReqNOAA.Model.TextProductTypeCollection},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns metadata about a given observation station

  ### Parameters

  - `station_id` (String.t): Observation station ID
  """
  @spec obs_station(String.t()) ::
          {:ok, ReqNOAA.Model.ObservationStationGeoJson.t()}
          | {:ok, ReqNOAA.Model.ObservationStationJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def obs_station(station_id) do
    ReqNOAA.new()
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
  @spec obs_stations(keyword()) ::
          {:ok, ReqNOAA.Model.ObservationStationGeoJson.t()}
          | {:ok, ReqNOAA.Model.ObservationStationJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def obs_stations(opts \\ []) do
    ReqNOAA.new()
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
  Returns metadata about a NWS forecast office

  ### Parameters

  - `office_id` (NwsOfficeId): NWS office ID
  """
  @spec office(ReqNOAA.Model.NwsOfficeId.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.Office.t()} | {:error, any()}
  def office(office_id) do
    ReqNOAA.new()
    |> Req.get(
      url: "/offices/:office_id",
      path_params: [office_id: office_id]
    )
    |> handle_response([
      {200, ReqNOAA.Model.Office},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a specific news headline for a given NWS office

  ### Parameters

  - `office_id` (NwsOfficeId): NWS office ID
  - `headline_id` (String.t): Headline record ID
  """
  @spec office_headline(ReqNOAA.Model.NwsOfficeId.t(), String.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.OfficeHeadline.t()} | {:error, any()}
  def office_headline(office_id, headline_id) do
    ReqNOAA.new()
    |> Req.get(
      url: "/offices/:office_id/headlines/:headline_id",
      path_params: [office_id: office_id, headline_id: headline_id]
    )
    |> handle_response([
      {200, ReqNOAA.Model.OfficeHeadline},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of news headlines for a given NWS office

  ### Parameters

  - `office_id` (NwsOfficeId): NWS office ID
  """
  @spec office_headlines(ReqNOAA.Model.NwsOfficeId.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.OfficeHeadlineCollection.t()} | {:error, any()}
  def office_headlines(office_id) do
    ReqNOAA.new()
    |> Req.get(
      url: "/offices/:office_id/headlines",
      path_params: [office_id: office_id]
    )
    |> handle_response([
      {200, ReqNOAA.Model.OfficeHeadlineCollection},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns metadata about a given latitude/longitude point

  ### Parameters

  - `point` (String.t): Point (latitude, longitude)
  """
  @spec point(String.t()) ::
          {:ok, ReqNOAA.Model.PointGeoJson.t()}
          | {:ok, ReqNOAA.Model.PointJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def point(point) do
    ReqNOAA.new()
    |> Req.get(
      url: "/points/:point",
      path_params: [point: point]
    )
    |> handle_response([
      {200, "application/geo+json", ReqNOAA.Model.PointGeoJson},
      {200, "application/ld+json", ReqNOAA.Model.PointJsonLd},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of observation stations for a given point

  ### Parameters

  - `point` (String.t): Point (latitude, longitude)
  """
  @spec point_stations(String.t()) ::
          {:ok, nil}
          | {:ok, ReqNOAA.Model.PointGeoJson.t()}
          | {:ok, ReqNOAA.Model.PointJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def point_stations(point) do
    ReqNOAA.new()
    |> Req.get(
      url: "/points/:point/stations",
      path_params: [point: point]
    )
    |> handle_response([
      {200, "application/geo+json", ReqNOAA.Model.PointGeoJson},
      {200, "application/ld+json", ReqNOAA.Model.PointJsonLd},
      {301, %{}},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a specific text product

  ### Parameters

  - `product_id` (String.t): .
  """
  @spec product(String.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.TextProduct.t()} | {:error, any()}
  def product(product_id) do
    ReqNOAA.new()
    |> Req.get(
      url: "/products/:product_id",
      path_params: [product_id: product_id]
    )
    |> handle_response([
      {200, ReqNOAA.Model.TextProduct},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of valid text product issuance locations
  """
  @spec product_locations() ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.TextProductLocationCollection.t()} | {:error, any()}
  def product_locations do
    ReqNOAA.new()
    |> Req.get(url: "/products/locations")
    |> handle_response([
      {200, ReqNOAA.Model.TextProductLocationCollection},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of valid text product types and codes
  """
  @spec product_types() ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.TextProductTypeCollection.t()} | {:error, any()}
  def product_types do
    ReqNOAA.new()
    |> Req.get(url: "/products/types")
    |> handle_response([
      {200, ReqNOAA.Model.TextProductTypeCollection},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of text products

  ### Options

    - `:location` ([String.t]): Location id
    - `:start` (DateTime.t): Start time
    - `:end` (DateTime.t): End time
    - `:office` ([String.t]): Issuing office
    - `:wmoid` ([String.t]): WMO id code
    - `:type` ([String.t]): Product code
    - `:limit` (integer()): Limit
  """
  @spec products_query(keyword()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.TextProductCollection.t()} | {:error, any()}
  def products_query(opts \\ []) do
    ReqNOAA.new()
    |> Req.get(
      url: "/products",
      params: Keyword.take(opts, [:location, :start, :end, :office, :wmoid, :type, :limit])
    )
    |> handle_response([
      {200, ReqNOAA.Model.TextProductCollection},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of text products of a given type

  ### Parameters

  - `type_id` (String.t): .
  """
  @spec products_type(String.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.TextProductCollection.t()} | {:error, any()}
  def products_type(type_id) do
    ReqNOAA.new()
    |> Req.get(
      url: "/products/types/:type_id",
      path_params: [type_id: type_id]
    )
    |> handle_response([
      {200, ReqNOAA.Model.TextProductCollection},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of text products of a given type for a given issuance location

  ### Parameters

  - `type_id` (String.t): .
  - `location_id` (String.t): .
  """
  @spec products_type_location(String.t(), String.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.TextProductCollection.t()} | {:error, any()}
  def products_type_location(type_id, location_id) do
    ReqNOAA.new()
    |> Req.get(
      url: "/products/types/:type_id/locations/:location_id",
      path_params: [type_id: type_id, location_id: location_id]
    )
    |> handle_response([
      {200, ReqNOAA.Model.TextProductCollection},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of valid text product issuance locations for a given product type

  ### Parameters

  - `type_id` (String.t): .
  """
  @spec products_type_locations(String.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.TextProductLocationCollection.t()} | {:error, any()}
  def products_type_locations(type_id) do
    ReqNOAA.new()
    |> Req.get(
      url: "/products/types/:type_id/locations",
      path_params: [type_id: type_id]
    )
    |> handle_response([
      {200, ReqNOAA.Model.TextProductLocationCollection},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns metadata about a given radar wind profiler

  ### Parameters

  - `station_id` (String.t): Profiler station ID

  ### Options

    - `:time` (Iso8601Interval): Time interval
    - `:interval` (String.t): Averaging interval
  """
  @spec radar_profiler(String.t(), keyword()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, any()} | {:error, any()}
  def radar_profiler(station_id, opts \\ []) do
    ReqNOAA.new()
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
  @spec radar_queue(String.t(), keyword()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, any()} | {:error, any()}
  def radar_queue(host, opts \\ []) do
    ReqNOAA.new()
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
  @spec radar_server(String.t(), keyword()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, any()} | {:error, any()}
  def radar_server(id, opts \\ []) do
    ReqNOAA.new()
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
  @spec radar_servers(keyword()) :: {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, any()} | {:error, any()}
  def radar_servers(opts \\ []) do
    ReqNOAA.new()
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
  @spec radar_station(String.t(), keyword()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, any()} | {:error, any()}
  def radar_station(station_id, opts \\ []) do
    ReqNOAA.new()
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
  @spec radar_station_alarms(String.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, any()} | {:error, any()}
  def radar_station_alarms(station_id) do
    ReqNOAA.new()
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
  @spec radar_stations(keyword()) :: {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, any()} | {:error, any()}
  def radar_stations(opts \\ []) do
    ReqNOAA.new()
    |> Req.get(
      url: "/radar/stations",
      params: Keyword.take(opts, [:stationType, :reportingHost, :host])
    )
    |> handle_response([
      {200, %{}},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a thumbnail image for a satellite region. Image services in API are deprecated.

  ### Parameters

  - `area` (String.t): .
  """
  @spec satellite_thumbnails(String.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, String.t()} | {:error, any()}
  def satellite_thumbnails(area) do
    ReqNOAA.new()
    |> Req.get(
      url: "/thumbnails/satellite/:area",
      path_params: [area: area]
    )
    |> handle_response([
      {200, %{}},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a specific SIGMET/AIRMET

  ### Parameters

  - `atsu` (String.t): ATSU identifier
  - `date` (Date.t): Date (YYYY-MM-DD format)
  - `time` (String.t): Time (HHMM format). This time is always specified in UTC (Zulu) time.
  """
  @spec sigmet(String.t(), Date.t(), String.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.SigmetGeoJson.t()} | {:error, any()}
  def sigmet(atsu, date, time) do
    ReqNOAA.new()
    |> Req.get(
      url: "/aviation/sigmets/:atsu/:date/:time",
      path_params: [atsu: atsu, date: date, time: time]
    )
    |> handle_response([
      {200, ReqNOAA.Model.SigmetGeoJson},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of SIGMET/AIRMETs

  ### Options

    - `:start` (DateTime.t): Start time
    - `:end` (DateTime.t): End time
    - `:date` (Date.t): Date (YYYY-MM-DD format)
    - `:atsu` (String.t): ATSU identifier
    - `:sequence` (String.t): SIGMET sequence number
  """
  @spec sigmet_query(keyword()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.SigmetCollectionGeoJson.t()} | {:error, any()}
  def sigmet_query(opts \\ []) do
    ReqNOAA.new()
    |> Req.get(
      url: "/aviation/sigmets",
      params: Keyword.take(opts, [:start, :end, :date, :atsu, :sequence])
    )
    |> handle_response([
      {200, ReqNOAA.Model.SigmetCollectionGeoJson},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of SIGMET/AIRMETs for the specified ATSU

  ### Parameters

  - `atsu` (String.t): ATSU identifier
  """
  @spec sigmets_by_atsu(String.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.SigmetCollectionGeoJson.t()} | {:error, any()}
  def sigmets_by_atsu(atsu) do
    ReqNOAA.new()
    |> Req.get(
      url: "/aviation/sigmets/:atsu",
      path_params: [atsu: atsu]
    )
    |> handle_response([
      {200, ReqNOAA.Model.SigmetCollectionGeoJson},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of SIGMET/AIRMETs for the specified ATSU for the specified date

  ### Parameters

  - `atsu` (String.t): ATSU identifier
  - `date` (Date.t): Date (YYYY-MM-DD format)
  """
  @spec sigmets_by_atsu_by_date(String.t(), Date.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.SigmetCollectionGeoJson.t()} | {:error, any()}
  def sigmets_by_atsu_by_date(atsu, date) do
    ReqNOAA.new()
    |> Req.get(
      url: "/aviation/sigmets/:atsu/:date",
      path_params: [atsu: atsu, date: date]
    )
    |> handle_response([
      {200, ReqNOAA.Model.SigmetCollectionGeoJson},
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
  @spec station_observation_latest(String.t(), keyword()) ::
          {:ok, ReqNOAA.Model.ObservationGeoJson.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def station_observation_latest(station_id, opts \\ []) do
    ReqNOAA.new()
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
  @spec station_observation_list(String.t(), keyword()) ::
          {:ok, ReqNOAA.Model.ObservationCollectionGeoJson.t()}
          | {:ok, ReqNOAA.Model.ObservationCollectionJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def station_observation_list(station_id, opts \\ []) do
    ReqNOAA.new()
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
  @spec station_observation_time(String.t(), DateTime.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.ObservationGeoJson.t()} | {:error, any()}
  def station_observation_time(station_id, time) do
    ReqNOAA.new()
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
    ReqNOAA.new()
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
    ReqNOAA.new()
    |> Req.get(
      url: "/stations/:station_id/tafs",
      path_params: [station_id: station_id]
    )
    |> handle_response([
      {200, %{}},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

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
    ReqNOAA.new()
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
  @spec zone_forecast(String.t(), String.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.ZoneForecastGeoJson.t()} | {:error, any()}
  def zone_forecast(type, zone_id) do
    ReqNOAA.new()
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
  @spec zone_list(keyword()) ::
          {:ok, ReqNOAA.Model.ZoneCollectionGeoJson.t()} | {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:error, any()}
  def zone_list(opts \\ []) do
    ReqNOAA.new()
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
  @spec zone_list_type(nws_zone_type()) ::
          {:ok, ReqNOAA.Model.ZoneCollectionGeoJson.t()} | {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:error, any()}
  def zone_list_type(type, opts \\ []) do
    ReqNOAA.new()
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
  @spec zone_obs(String.t(), keyword()) ::
          {:ok, ReqNOAA.Model.ObservationCollectionGeoJson.t()}
          | {:ok, ReqNOAA.Model.ObservationCollectionJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def zone_obs(zone_id, opts \\ []) do
    ReqNOAA.new()
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
  @spec zone_stations(String.t(), keyword()) ::
          {:ok, ReqNOAA.Model.ObservationStationCollectionGeoJson.t()}
          | {:ok, ReqNOAA.Model.ObservationStationCollectionJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def zone_stations(zone_id, opts \\ []) do
    ReqNOAA.new()
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
  @spec zone_forecast(String.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.ZoneGeoJson.t()} | {:error, any()}
  def zone_forecast(zone_id) do
    ReqNOAA.new()
    |> Req.get(
      url: "/zones/forecast/:zone_id",
      path_params: [zone_id: zone_id]
    )
    |> handle_response([
      {200, ReqNOAA.Model.ZoneGeoJson},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  defp handle_response({:ok, %Response{} = resp}, mapping), do: resolve_mapping(resp, mapping, nil)
  defp handle_response({:error, _} = error, _), do: error

  defp resolve_mapping(%Response{status: status} = resp, [{status, content_type, struct} | tail], default) do
    case resp.headers["content-type"] do
      [^content_type] -> decode(resp, struct)
      _ -> resolve_mapping(resp, tail, default)
    end
  end

  defp resolve_mapping(%Response{status: status} = resp, [{status, struct} | _], _), do: decode(resp, struct)

  defp resolve_mapping(resp, [{:default, struct} | tail], _), do: resolve_mapping(resp, tail, struct)
  defp resolve_mapping(resp, [_ | tail], default), do: resolve_mapping(resp, tail, default)
  defp resolve_mapping(resp, [], nil), do: {:error, resp}
  defp resolve_mapping(resp, [], default), do: decode(resp, default)

  defp decode(%Response{} = resp, false), do: {:ok, resp}
  defp decode(%Response{body: body}, %{}), do: ReqNOAA.Model.jason_decode(body)
  defp decode(%Response{body: body}, module), do: ReqNOAA.Model.jason_decode(body, module)
end
