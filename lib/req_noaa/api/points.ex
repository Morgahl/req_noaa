defmodule ReqNOAA.API.Points do
  @moduledoc """
  NOAA Points API
  """

  import ReqNOAA.API, only: [handle_response: 2]
  alias ReqNOAA.API

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
    API.new()
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
  @spec stations(String.t()) ::
          {:ok, nil}
          | {:ok, ReqNOAA.Model.PointGeoJson.t()}
          | {:ok, ReqNOAA.Model.PointJsonLd.t()}
          | {:ok, ReqNOAA.Model.ProblemDetail.t()}
          | {:error, any()}
  def stations(point) do
    API.new()
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
end
