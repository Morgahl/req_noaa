defmodule ReqNOAA.API.Alerts do
  @moduledoc """
  NOAA Weather Alerts API
  """

  import ReqNOAA.API, only: [handle_response: 2]
  alias ReqNOAA.API

  @typedoc """
  Alert urgency

  - `"immediate"`: Immediate
  - `"expected"`: Expected
  - `"future"`: Future
  - `"past"`: Past
  - `"unknown"`: Unknown
  """
  @type urgency() :: String.t()

  @typedoc """
  Alert severity

  - `"extreme"`: Extreme
  - `"severe"`: Severe
  - `"moderate"`: Moderate
  - `"minor"`: Minor
  - `"unknown"`: Unknown
  """
  @type severity() :: String.t()

  @typedoc """
  Alert certainty

  - `"observed"`: Observed
  - `"likely"`: Likely
  - `"possible"`: Possible
  - `"unlikely"`: Unlikely
  - `"unknown"`: Unknown
  """
  @type certainty() :: String.t()

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
    - `:urgency` ([urgency]): Urgency (immediate, expected, future, past, unknown)
    - `:severity` ([severity]): Severity (extreme, severe, moderate, minor, unknown)
    - `:certainty` ([certainty]): Certainty (observed, likely, possible, unlikely, unknown)
    - `:limit` (integer()): Limit
  """
  @spec active(keyword()) ::
          {:ok, nil}
          | {:ok, ReqNOAA.Model.AlertCollectionGeoJson.t()}
          | {:ok, ReqNOAA.Model.AlertCollectionJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def active(opts \\ []) do
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

    API.new()
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
  @spec active_area(API.area_code()) ::
          {:ok, ReqNOAA.Model.AlertCollectionGeoJson.t()}
          | {:ok, ReqNOAA.Model.AlertCollectionJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def active_area(area) do
    API.new()
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
  @spec active_count() ::
          {:ok, ReqNOAA.Model.AlertsActiveCountResponse.t()} | {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:error, any()}
  def active_count do
    API.new()
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
  @spec active_region(ReqNOAA.Model.MarineRegionCode.t()) ::
          {:ok, ReqNOAA.Model.AlertCollectionGeoJson.t()}
          | {:ok, ReqNOAA.Model.AlertCollectionJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def active_region(region) do
    API.new()
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
  @spec active_zone(String.t()) ::
          {:ok, ReqNOAA.Model.AlertCollectionGeoJson.t()}
          | {:ok, ReqNOAA.Model.AlertCollectionJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def active_zone(zone_id) do
    API.new()
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
  - `:urgency` ([urgency]): Urgency (immediate, expected, future, past, unknown)
  - `:severity` ([severity]): Severity (extreme, severe, moderate, minor, unknown)
  - `:certainty` ([certainty]): Certainty (observed, likely, possible, unlikely, unknown)
  - `:limit` (integer()): Limit
  - `:cursor` (String.t): Pagination cursor
  """
  @spec query(keyword()) ::
          {:ok, nil}
          | {:ok, ReqNOAA.Model.AlertCollectionGeoJson.t()}
          | {:ok, ReqNOAA.Model.AlertCollectionJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def query(opts \\ []) do
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

    API.new()
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
  @spec single(String.t()) ::
          {:ok, ReqNOAA.Model.AlertGeoJson.t()}
          | {:ok, ReqNOAA.Model.AlertJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def single(id) do
    API.new()
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
  @spec types() ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.AlertsTypesResponse.t()} | {:error, any()}
  def types do
    API.new()
    |> Req.get(url: "/alerts/types")
    |> handle_response([
      {200, ReqNOAA.Model.AlertsTypesResponse},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end
end
