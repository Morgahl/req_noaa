defmodule ReqNOAA.API.Aviation do
  @moduledoc """
  NOAA Aviation Weather API
  """

  import ReqNOAA.API, only: [handle_response: 2]
  alias ReqNOAA.API

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
    API.new()
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
    API.new()
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
    API.new()
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
  Returns a specific SIGMET/AIRMET

  ### Parameters

  - `atsu` (String.t): ATSU identifier
  - `date` (Date.t): Date (YYYY-MM-DD format)
  - `time` (String.t): Time (HHMM format). This time is always specified in UTC (Zulu) time.
  """
  @spec sigmet(String.t(), Date.t(), String.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.SigmetGeoJson.t()} | {:error, any()}
  def sigmet(atsu, date, time) do
    API.new()
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
    API.new()
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
    API.new()
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
    API.new()
    |> Req.get(
      url: "/aviation/sigmets/:atsu/:date",
      path_params: [atsu: atsu, date: date]
    )
    |> handle_response([
      {200, ReqNOAA.Model.SigmetCollectionGeoJson},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end
end
