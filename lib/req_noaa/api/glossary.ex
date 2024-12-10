defmodule ReqNOAA.API.Glossary do
  @moduledoc """
  NOAA Glossary API
  """

  import ReqNOAA.API, only: [handle_response: 2]
  alias ReqNOAA.API

  @doc """
  Returns glossary terms
  """
  @spec glossary() ::
          {:ok, ReqNOAA.Model.ProblemDetail.t()} | {:ok, ReqNOAA.Model.GlossaryResponse.t()} | {:error, any()}
  def glossary() do
    API.new()
    |> Req.get(url: "/glossary")
    |> handle_response([
      {200, ReqNOAA.Model.GlossaryResponse},
      {:default, ReqNOAA.Model.ProblemDetail}
    ])
  end
end
