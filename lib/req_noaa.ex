defmodule ReqNOAA do
  @moduledoc """
  Module to request data from NOAA API
  """
  alias Req.Request
  alias ReqNOAA.Api

  @type t() :: Request.t()

  @vsn Mix.Project.config()[:version]

  @base_url "https://api.weather.gov"
  @app_name Application.compile_env!(:req_noaa, :name)
  @app_contact Application.compile_env!(:req_noaa, :contact)
  @user_agent "ReqNOAA #{@vsn} (#{@app_name} #{@app_contact})"

  @spec new() :: Req.Request.t()
  def new() do
    Req.new(
      base_url: @base_url,
      headers: [
        user_agent: @user_agent,
        accept: "application/geo+json, application/ld+json"
      ],
      cache: true,
      decode_body: false
    )
  end

  defdelegate alerts(opts \\ []), to: Api, as: :alerts_query
  defdelegate alerts_active(opts \\ []), to: Api, as: :alerts_active
  defdelegate alerts_active_count, to: Api, as: :alerts_active_count
  defdelegate alerts_active_zone(zone_id), to: Api, as: :alerts_active_zone
  defdelegate alerts_active_area(area_id), to: Api, as: :alerts_active_area
  defdelegate alerts_active_region(region_id), to: Api, as: :alerts_active_region
  defdelegate alerts_types, to: Api, as: :alerts_types
  defdelegate cwsu(cwsu_id), to: Api, as: :cwsu
  defdelegate cwas(cwsu_id), to: Api, as: :cwas
  defdelegate cwa(cwa_id, date, sequence), to: Api, as: :cwa
  defdelegate sigmets(opts \\ []), to: Api, as: :sigmet_query
  defdelegate sigmets_by_atsu(atsu), to: Api, as: :sigmets_by_atsu
  defdelegate sigmets_by_atsu_by_date(atsu, date), to: Api, as: :sigmets_by_atsu_by_date
  defdelegate sigmet(atsu, date, time), to: Api, as: :sigmet
  defdelegate glossary, to: Api, as: :glossary
  defdelegate gridpoint(wfo, x, y), to: Api, as: :gridpoint
  defdelegate gridpoint_forecast(wfo, x, y, opts \\ []), to: Api, as: :gridpoint_forecast
  defdelegate gridpoint_forecast_hourly(wfo, x, y, opts \\ []), to: Api, as: :gridpoint_forecast_hourly
  defdelegate gridpoint_stations(wfo, x, y, opts \\ []), to: Api, as: :gridpoint_stations
  defdelegate station_observation_list(station_id, opts \\ []), to: Api, as: :station_observation_list
  defdelegate station_observation_latest(station_id, opts \\ []), to: Api, as: :station_observation_latest
  defdelegate station_observation_time(station_id, time), to: Api, as: :station_observation_time
  defdelegate tafs(station_id), to: Api, as: :tafs
  defdelegate taf(station_id, date, time), to: Api, as: :taf
  defdelegate obs_stations(opts \\ []), to: Api, as: :obs_stations
  defdelegate obs_station(station_id), to: Api, as: :obs_station
  defdelegate office(office_id), to: Api, as: :office
  defdelegate office_headline(office_id, headline_id), to: Api, as: :office_headline
  defdelegate office_headlines(office_id), to: Api, as: :office_headlines
  defdelegate point_stations(lat_long), to: Api, as: :point_stations
end
