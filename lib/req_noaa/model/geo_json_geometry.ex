defmodule ReqNOAA.Model.GeoJsonGeometry do
  @moduledoc """
  A GeoJSON geometry object. Please refer to IETF RFC 7946 for information on the GeoJSON format.
  """

  @typedoc """
  A GeoJSON geometry object type.

  - `"Point"`: A GeoJSON point geometry.
  - `"LineString"`: A GeoJSON line string geometry.
  - `"Polygon"`: A GeoJSON polygon geometry.
  - `"MultiPoint"`: A GeoJSON multi-point geometry.
  - `"MultiLineString"`: A GeoJSON multi-line string geometry.
  - `"MultiPolygon"`: A GeoJSON multi-polygon geometry.
  """
  @type type :: String.t()

  @type coords() :: nonempty_improper_list(float(), float()) | [coords()]

  @derive Jason.Encoder
  defstruct [
    :type,
    :coordinates,
    :bbox
  ]

  @type t :: %__MODULE__{
          :type => type(),
          :coordinates => [coords()],
          :bbox => [float()] | nil
        }

  def decode(value) do
    value
  end
end
