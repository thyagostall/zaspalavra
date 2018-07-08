defmodule Zaspalavra.Repo.Migrations.CreateWords do
  use Ecto.Migration

  def change do
    create table(:words) do
      add :prefix, :string
      add :word, :string
      add :votes, :integer

      timestamps()
    end

  end
end
