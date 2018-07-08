defmodule Zaspalavra.Repo.Migrations.CreateWords do
  use Ecto.Migration

  def change do
    create table(:words) do
      add :prefix, :string, size: 10, null: false
      add :word, :string, size: 50, null: false
      add :votes, :integer, null: false, default: 0

      timestamps()
    end

    create index(:words, [:word], unique: true)
  end
end
