defmodule ReqNOAA.Model.Alert do
  @moduledoc """
  An object representing a public alert message. Unless otherwise noted, the fields in this object correspond to the National Weather Service CAP v1.2 specification, which extends the OASIS Common Alerting Protocol (CAP) v1.2 specification and USA Integrated Public Alert and Warning System (IPAWS) Profile v1.0. Refer to this documentation for more complete information. http://docs.oasis-open.org/emergency/cap/v1.2/CAP-v1.2-os.html http://docs.oasis-open.org/emergency/cap/v1.2/ipaws-profile/v1.0/cs01/cap-v1.2-ipaws-profile-cs01.html https://alerts.weather.gov/#technical-notes-v12
  """

  @derive Jason.Encoder
  defstruct [
    :id,
    :areaDesc,
    :geocode,
    :affectedZones,
    :references,
    :sent,
    :effective,
    :onset,
    :expires,
    :ends,
    :status,
    :messageType,
    :category,
    :severity,
    :certainty,
    :urgency,
    :event,
    :sender,
    :senderName,
    :headline,
    :description,
    :instruction,
    :response,
    :parameters
  ]

  @type t :: %__MODULE__{
          :id => String.t() | nil,
          :areaDesc => String.t() | nil,
          :geocode => ReqNOAA.Model.AlertGeocode.t() | nil,
          :affectedZones => [String.t()] | nil,
          :references => [ReqNOAA.Model.AlertReferencesInner.t()] | nil,
          :sent => DateTime.t() | nil,
          :effective => DateTime.t() | nil,
          :onset => DateTime.t() | nil,
          :expires => DateTime.t() | nil,
          :ends => DateTime.t() | nil,
          :status => String.t() | nil,
          :messageType => String.t() | nil,
          :category => String.t() | nil,
          :severity => String.t() | nil,
          :certainty => String.t() | nil,
          :urgency => String.t() | nil,
          :event => String.t() | nil,
          :sender => String.t() | nil,
          :senderName => String.t() | nil,
          :headline => String.t() | nil,
          :description => String.t() | nil,
          :instruction => String.t() | nil,
          :response => String.t() | nil,
          :parameters => %{optional(String.t()) => [any()]} | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:geocode, :struct, ReqNOAA.Model.AlertGeocode)
    |> Model.deserialize(:references, :list, ReqNOAA.Model.AlertReferencesInner)
    |> Model.deserialize(:sent, :datetime, nil)
    |> Model.deserialize(:effective, :datetime, nil)
    |> Model.deserialize(:onset, :datetime, nil)
    |> Model.deserialize(:expires, :datetime, nil)
    |> Model.deserialize(:ends, :datetime, nil)
  end
end
