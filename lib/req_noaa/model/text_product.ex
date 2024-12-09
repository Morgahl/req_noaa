defmodule ReqNOAA.Model.TextProduct do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :"@context",
    :"@id",
    :id,
    :wmoCollectiveId,
    :issuingOffice,
    :issuanceTime,
    :productCode,
    :productName,
    :productText
  ]

  @type t :: %__MODULE__{
          :"@context" => ReqNOAA.Model.JsonLdContext.t() | nil,
          :"@id" => String.t() | nil,
          :id => String.t() | nil,
          :wmoCollectiveId => String.t() | nil,
          :issuingOffice => String.t() | nil,
          :issuanceTime => DateTime.t() | nil,
          :productCode => String.t() | nil,
          :productName => String.t() | nil,
          :productText => String.t() | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:issuanceTime, :datetime, nil)
  end
end
