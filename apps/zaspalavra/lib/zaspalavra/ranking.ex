defmodule Zaspalavra.Ranking do
  import Ecto.Query

  alias Zaspalavra.Words.Word
  alias Zaspalavra.Repo

  def take_best(count) do
    positions = Range.new(1, count)
    |> Enum.map(&(%{position: &1}))

    query(count)
    |> Repo.all()
    |> Enum.map(&Word.fill_in_dynamic_fields/1)
    |> Enum.map(&Map.from_struct/1)
    |> Enum.zip(positions)
    |> Enum.map(&merge/1)
  end

  defp query(count) do
    from w in Word, order_by: [desc: w.votes], limit: ^count
  end

  defp merge({word, position}), do: Map.merge(word, position)
end
