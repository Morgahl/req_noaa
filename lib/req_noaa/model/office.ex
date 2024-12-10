defmodule ReqNOAA.Model.Office do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :"@context",
    :"@type",
    :"@id",
    :id,
    :name,
    :address,
    :telephone,
    :faxNumber,
    :email,
    :sameAs,
    :nwsRegion,
    :parentOrganization,
    :responsibleCounties,
    :responsibleForecastZones,
    :responsibleFireZones,
    :approvedObservationStations
  ]

  @type t :: %__MODULE__{
          :"@context" => any() | nil,
          :"@type" => String.t() | nil,
          :"@id" => String.t() | nil,
          :id => String.t() | nil,
          :name => String.t() | nil,
          :address => ReqNOAA.Model.OfficeAddress.t() | nil,
          :telephone => String.t() | nil,
          :faxNumber => String.t() | nil,
          :email => String.t() | nil,
          :sameAs => String.t() | nil,
          :nwsRegion => String.t() | nil,
          :parentOrganization => String.t() | nil,
          :responsibleCounties => [String.t()] | nil,
          :responsibleForecastZones => [String.t()] | nil,
          :responsibleFireZones => [String.t()] | nil,
          :approvedObservationStations => [String.t()] | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:address, :struct, ReqNOAA.Model.OfficeAddress)
  end
end
