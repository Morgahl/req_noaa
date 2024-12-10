defmodule ReqNOAA.API.Products do
  @moduledoc """
  NOAA Products API
  """

  import ReqNOAA.API, only: [handle_response: 2]
  alias ReqNOAA.API

  @doc """
  Returns a list of valid text product types for a given issuance location

  ### Parameters

  - `location_id` (String.t): .
  """
  @spec location_types(String.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.TextProductTypeCollection.t()} | {:error, any()}
  def location_types(location_id) do
    API.new()
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
  Returns a specific text product

  ### Parameters

  - `product_id` (String.t): .
  """
  @spec product(String.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.TextProduct.t()} | {:error, any()}
  def product(product_id) do
    API.new()
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
  @spec locations() ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.TextProductLocationCollection.t()} | {:error, any()}
  def locations do
    API.new()
    |> Req.get(url: "/products/locations")
    |> handle_response([
      {200, ReqNOAA.Model.TextProductLocationCollection},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end

  @doc """
  Returns a list of valid text product types and codes
  """
  @spec types() ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.TextProductTypeCollection.t()} | {:error, any()}
  def types do
    API.new()
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
  @spec query(keyword()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.TextProductCollection.t()} | {:error, any()}
  def query(opts \\ []) do
    API.new()
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
  @spec type(String.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.TextProductCollection.t()} | {:error, any()}
  def type(type_id) do
    API.new()
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
  @spec type_location(String.t(), String.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.TextProductCollection.t()} | {:error, any()}
  def type_location(type_id, location_id) do
    API.new()
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
  @spec type_locations(String.t()) ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.TextProductLocationCollection.t()} | {:error, any()}
  def type_locations(type_id) do
    API.new()
    |> Req.get(
      url: "/products/types/:type_id/locations",
      path_params: [type_id: type_id]
    )
    |> handle_response([
      {200, ReqNOAA.Model.TextProductLocationCollection},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end
end
