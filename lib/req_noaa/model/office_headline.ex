defmodule ReqNOAA.Model.OfficeHeadline do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :"@context",
    :"@id",
    :id,
    :office,
    :important,
    :issuanceTime,
    :link,
    :name,
    :title,
    :summary,
    :content
  ]

  @type t :: %__MODULE__{
          :"@context" => any() | nil,
          :"@id" => String.t() | nil,
          :id => String.t() | nil,
          :office => String.t() | nil,
          :important => boolean() | nil,
          :issuanceTime => DateTime.t() | nil,
          :link => String.t() | nil,
          :name => String.t() | nil,
          :title => String.t() | nil,
          :summary => String.t() | nil,
          :content => String.t() | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:issuanceTime, :datetime, nil)
  end
end
