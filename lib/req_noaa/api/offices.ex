defmodule ReqNOAA.API.Offices do
  @moduledoc """
  NOAA Offices API
  """

  import ReqNOAA.API, only: [handle_response: 2]
  alias ReqNOAA.API

  @doc """
  Returns metadata about a NWS forecast office

  ### Parameters

  - `office_id` (NwsOfficeId): NWS office ID
  """
  @spec office(API.nws_office_id()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.Office.t()} | {:error, any()}
  def office(office_id) do
    API.new()
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
  @spec headline(API.nws_office_id(), String.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.OfficeHeadline.t()} | {:error, any()}
  def headline(office_id, headline_id) do
    API.new()
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
  @spec headlines(API.nws_office_id()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.OfficeHeadlineCollection.t()} | {:error, any()}
  def headlines(office_id) do
    API.new()
    |> Req.get(
      url: "/offices/:office_id/headlines",
      path_params: [office_id: office_id]
    )
    |> handle_response([
      {200, ReqNOAA.Model.OfficeHeadlineCollection},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end
end
