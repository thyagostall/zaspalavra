defmodule Zaspalavra.Words.Word do
  use Ecto.Schema
  import Ecto.Changeset


  schema "words" do
    field :prefix, :string
    field :votes, :integer
    field :word, :string

    timestamps()
  end

  @doc false
  def changeset(word, attrs) do
    word
    |> cast(attrs, [:prefix, :word, :votes])
    |> validate_required([:prefix, :word, :votes])
  end
end
