defmodule ReqNOAA.Model.Zone do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :"@context",
    :geometry,
    :"@id",
    :"@type",
    :id,
    :type,
    :name,
    :effectiveDate,
    :expirationDate,
    :state,
    :forecastOffice,
    :gridIdentifier,
    :awipsLocationIdentifier,
    :cwa,
    :forecastOffices,
    :timeZone,
    :observationStations,
    :radarStation
  ]

  @type t :: %__MODULE__{
          :"@context" => any() | nil,
          :geometry => String.t() | nil,
          :"@id" => String.t() | nil,
          :"@type" => String.t() | nil,
          :id => String.t() | nil,
          :type => String.t() | nil,
          :name => String.t() | nil,
          :effectiveDate => DateTime.t() | nil,
          :expirationDate => DateTime.t() | nil,
          :state => String.t() | nil,
          :forecastOffice => String.t() | nil,
          :gridIdentifier => String.t() | nil,
          :awipsLocationIdentifier => String.t() | nil,
          :cwa => [String.t()] | nil,
          :forecastOffices => [String.t()] | nil,
          :timeZone => [String.t()] | nil,
          :observationStations => [String.t()] | nil,
          :radarStation => String.t() | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:effectiveDate, :datetime, nil)
    |> Model.deserialize(:expirationDate, :datetime, nil)
  end
end
