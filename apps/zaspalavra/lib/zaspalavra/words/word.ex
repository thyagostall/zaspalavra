defmodule Zaspalavra.Words.Word do
  use Ecto.Schema
  import Ecto.Changeset


  schema "words" do
    field :prefix, :string
    field :votes, :integer
    field :word, :string

    field :display_word, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(word, attrs) do
    word
    |> cast(attrs, [:prefix, :word, :votes])
    |> validate_required([:prefix, :word, :votes])
  end

  def fill_in_dynamic_fields(word) do
    %__MODULE__{word | display_word: word.prefix <> word.word}
  end
end
