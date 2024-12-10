defmodule ReqNOAA.API do
  @moduledoc """
  Module to request data from NOAA API
  """

  alias Req.Response

  @typedoc "State/territory code or marine area code"
  @type area_code :: String.t() | marine_region_code()

  @typedoc "Marine region code"
  @type marine_region_code() :: String.t()

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

  def handle_response({:ok, %Response{} = resp}, mapping), do: resolve_mapping(resp, mapping, nil)
  def handle_response({:error, _} = error, _), do: error

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
