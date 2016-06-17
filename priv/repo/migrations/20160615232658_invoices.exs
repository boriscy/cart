defmodule Cart.Repo.Migrations.Invoices do
  use Ecto.Migration

  def change do
    create table(:invoices, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :customer, :text
      add :amount, :decimal, precision: 12, scale: 2
      add :balance, :decimal, precision: 12, scale: 2
      add :date, :date
      add :invoice_items, :map, default: "[]"

      timestamps
    end
  end
end
