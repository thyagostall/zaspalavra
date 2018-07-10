defmodule Zaspalavra.Words do
  import Ecto.Query, warn: false

  alias Ecto.Adapters.SQL
  alias Zaspalavra.Repo
  alias Zaspalavra.Words.Word

  def list_words do
    Repo.all(Word)
  end

  def get_word!(id) do
    Repo.get!(Word, id)
    |> Word.fill_in_dynamic_fields()
  end

  def get_random_id() do
    sql = ~s[SELECT MIN(id) + FLOOR(RAND() * MAX(id)) random_id FROM words]
    %{rows: [[random_id]]} = SQL.query!(Repo, sql, [])
    random_id
    |> Kernel.trunc()
  end

  def approve(id) do
    sql = ~s[UPDATE words SET votes = votes + 1 WHERE id = ?]
    {result, _} = SQL.query(Repo, sql, [id])
    result
  end

  def reject(id) do
    sql = ~s[UPDATE words SET votes = votes - 1 WHERE id = ?]
    {result, _} = SQL.query(Repo, sql, [id])
    result
  end

  def create_word(attrs \\ %{}) do
    %Word{}
    |> Word.changeset(attrs)
    |> Repo.insert()
  end

  def update_word(%Word{} = word, attrs) do
    word
    |> Word.changeset(attrs)
    |> Repo.update()
  end

  def delete_word(%Word{} = word) do
    Repo.delete(word)
  end

  def change_word(%Word{} = word) do
    Word.changeset(word, %{})
  end
end
