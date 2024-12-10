defmodule ReqNOAA.API.Icons do
  @moduledoc """
  NOAA Icons API
  """

  import ReqNOAA.API, only: [handle_response: 2]
  alias ReqNOAA.API

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
    API.new()
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
    API.new()
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
    API.new()
    |> Req.get(url: "/icons")
    |> handle_response([
      {200, ReqNOAA.Model.IconsSummaryResponse},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end
end
