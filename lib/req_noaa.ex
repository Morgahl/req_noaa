defmodule ReqNOAA do
  @moduledoc """
  Module to request data from NOAA API
  """
  alias Req.Request

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
      cache_dir: get_cache_dir(),
      decode_body: false
    )
  end

  defp get_cache_dir() do
    Application.get_env(:req_noaa, :cache_dir) || Path.join([System.tmp_dir(), "req_noaa"])
  end
end
