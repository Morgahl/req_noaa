defmodule ReqNOAA.Model.AlertAtomEntry do
  @moduledoc """
  An alert entry in an Atom feed
  """

  @derive Jason.Encoder
  defstruct [
    :id,
    :updated,
    :published,
    :author,
    :summary,
    :event,
    :sent,
    :effective,
    :expires,
    :status,
    :msgType,
    :category,
    :urgency,
    :severity,
    :certainty,
    :areaDesc,
    :polygon,
    :geocode,
    :parameter
  ]

  @type t :: %__MODULE__{
          :id => String.t() | nil,
          :updated => String.t() | nil,
          :published => String.t() | nil,
          :author => ReqNOAA.Model.AlertAtomEntryAuthor.t() | nil,
          :summary => String.t() | nil,
          :event => String.t() | nil,
          :sent => String.t() | nil,
          :effective => String.t() | nil,
          :expires => String.t() | nil,
          :status => String.t() | nil,
          :msgType => String.t() | nil,
          :category => String.t() | nil,
          :urgency => String.t() | nil,
          :severity => String.t() | nil,
          :certainty => String.t() | nil,
          :areaDesc => String.t() | nil,
          :polygon => String.t() | nil,
          :geocode => [ReqNOAA.Model.AlertXmlParameter.t()] | nil,
          :parameter => [ReqNOAA.Model.AlertXmlParameter.t()] | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:author, :struct, ReqNOAA.Model.AlertAtomEntryAuthor)
    |> Model.deserialize(:geocode, :list, ReqNOAA.Model.AlertXmlParameter)
    |> Model.deserialize(:parameter, :list, ReqNOAA.Model.AlertXmlParameter)
  end
end
