defmodule ReqNOAA.Model.AlertAtomFeed do
  @moduledoc """
  An alert feed in Atom format
  """

  @derive Jason.Encoder
  defstruct [
    :id,
    :generator,
    :updated,
    :author,
    :title,
    :entry
  ]

  @type t :: %__MODULE__{
          :id => String.t() | nil,
          :generator => String.t() | nil,
          :updated => String.t() | nil,
          :author => ReqNOAA.Model.AlertAtomFeedAuthor.t() | nil,
          :title => String.t() | nil,
          :entry => [ReqNOAA.Model.AlertAtomEntry.t()] | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:author, :struct, ReqNOAA.Model.AlertAtomFeedAuthor)
    |> Model.deserialize(:entry, :list, ReqNOAA.Model.AlertAtomEntry)
  end
end
