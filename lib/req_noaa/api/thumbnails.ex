defmodule ReqNOAA.API.Thumbnails do
  @moduledoc """
  NOAA Thumbnails API
  """

  import ReqNOAA.API, only: [handle_response: 2]
  alias ReqNOAA.API

  @doc """
  Returns a thumbnail image for a satellite region. Image services in API are deprecated.

  ### Parameters

  - `area` (String.t): .
  """
  @spec satellite(String.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, String.t()} | {:error, any()}
  def satellite(area) do
    API.new()
    |> Req.get(
      url: "/thumbnails/satellite/:area",
      path_params: [area: area]
    )
    |> handle_response([
      {200, %{}},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end
end
