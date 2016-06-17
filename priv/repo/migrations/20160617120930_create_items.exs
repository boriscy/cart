defmodule Cart.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :text
      add :price, :decimal, precision: 12, scale: 2

      timestamps
    end
  end
end
