defmodule ReqNOAA.Model.ProblemDetail do
  @moduledoc """
  Detail about an error. This document conforms to RFC 7807 (Problem Details for HTTP APIs).
  """

  @derive Jason.Encoder
  defstruct [
    :type,
    :title,
    :status,
    :detail,
    :instance,
    :correlationId
  ]

  @type t :: %__MODULE__{
          :type => String.t(),
          :title => String.t(),
          :status => float(),
          :detail => String.t(),
          :instance => String.t(),
          :correlationId => String.t()
        }

  def decode(value) do
    value
  end
end
