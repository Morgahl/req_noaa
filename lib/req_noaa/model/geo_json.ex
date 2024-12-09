defmodule ReqNOAA.Model.GeoJson do
  @moduledoc false

  defmacro __using__(:map) do
    quote location: :keep do
      @derive Jason.Encoder
      defstruct [
        :"@context",
        :id,
        :type,
        :geometry,
        :properties
      ]

      @type t :: %__MODULE__{
              :"@context" => ReqNOAA.Model.JsonLdContext.t() | nil,
              :id => String.t() | nil,
              :type => String.t(),
              :geometry => ReqNOAA.Model.GeoJsonGeometry.t() | nil,
              :properties => map()
            }

      alias ReqNOAA.Model

      def decode(value) do
        value =
          value
          |> Model.deserialize(:geometry, :struct, ReqNOAA.Model.GeoJsonGeometry)
      end
    end
  end

  defmacro __using__({properties, type}) do
    quote location: :keep do
      @derive Jason.Encoder
      defstruct [
        :"@context",
        :id,
        :type,
        :geometry,
        :properties
      ]

      @type t :: %__MODULE__{
              :"@context" => ReqNOAA.Model.JsonLdContext.t() | nil,
              :id => String.t() | nil,
              :type => String.t(),
              :geometry => ReqNOAA.Model.GeoJsonGeometry.t() | nil,
              :properties => unquote(type)
            }

      alias ReqNOAA.Model

      def decode(value) do
        value =
          value
          |> Model.deserialize(:geometry, :struct, ReqNOAA.Model.GeoJsonGeometry)
          |> Model.deserialize(:properties, :struct, unquote(properties))
      end
    end
  end
end

defmodule ReqNOAA.Model.AlertGeoJson do
  @moduledoc false

  use ReqNOAA.Model.GeoJson, {ReqNOAA.Model.Alert, ReqNOAA.Model.Alert.t()}
end

defmodule ReqNOAA.Model.CenterWeatherAdvisoryGeoJson do
  @moduledoc false

  use ReqNOAA.Model.GeoJson, {ReqNOAA.Model.CenterWeatherAdvisory, ReqNOAA.Model.CenterWeatherAdvisory.t()}
end

defmodule ReqNOAA.Model.GeoJsonFeature do
  @moduledoc """
  A GeoJSON feature. Please refer to IETF RFC 7946 for information on the GeoJSON format.
  """

  use ReqNOAA.Model.GeoJson, :map
end

defmodule ReqNOAA.Model.GeoJsonFeatureCollection do
  @moduledoc """
  A GeoJSON feature collection. Please refer to IETF RFC 7946 for information on the GeoJSON format.
  """

  use ReqNOAA.Model.GeoJson, {ReqNOAA.Model.GeoJsonFeature, [ReqNOAA.Model.GeoJsonFeature.t()]}
end

defmodule ReqNOAA.Model.GridpointForecastGeoJson do
  @moduledoc false

  use ReqNOAA.Model.GeoJson, {ReqNOAA.Model.GridpointForecast, ReqNOAA.Model.GridpointForecast.t()}
end

defmodule ReqNOAA.Model.GridpointGeoJson do
  @moduledoc false

  use ReqNOAA.Model.GeoJson, {ReqNOAA.Model.Gridpoint, ReqNOAA.Model.Gridpoint.t()}
end

defmodule ReqNOAA.Model.ObservationGeoJson do
  @moduledoc false

  use ReqNOAA.Model.GeoJson, {ReqNOAA.Model.Observation, ReqNOAA.Model.Observation.t()}
end

defmodule ReqNOAA.Model.ObservationStationGeoJson do
  @moduledoc false

  use ReqNOAA.Model.GeoJson, {ReqNOAA.Model.ObservationStation, ReqNOAA.Model.ObservationStation.t()}
end

defmodule ReqNOAA.Model.PointGeoJson do
  @moduledoc false

  use ReqNOAA.Model.GeoJson, :map
end

defmodule ReqNOAA.Model.RelativeLocationGeoJson do
  @moduledoc false

  use ReqNOAA.Model.GeoJson, {ReqNOAA.Model.RelativeLocation, ReqNOAA.Model.RelativeLocation.t()}
end

defmodule ReqNOAA.Model.SigmetGeoJson do
  @moduledoc false

  use ReqNOAA.Model.GeoJson, {ReqNOAA.Model.Sigmet, ReqNOAA.Model.Sigmet.t()}
end

defmodule ReqNOAA.Model.ZoneForecastGeoJson do
  @moduledoc false

  use ReqNOAA.Model.GeoJson, {ReqNOAA.Model.ZoneForecast, ReqNOAA.Model.ZoneForecast.t()}
end

defmodule ReqNOAA.Model.ZoneGeoJson do
  @moduledoc false

  use ReqNOAA.Model.GeoJson, {ReqNOAA.Model.Zone, ReqNOAA.Model.Zone.t()}
end
