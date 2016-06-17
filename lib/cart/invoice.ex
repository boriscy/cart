defmodule Cart.Invoice do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "invoices" do
    field :customer
    field :amount, :decimal, precision: 12, scale: 2
    field :balance, :decimal, precision: 12, scale: 2
    field :date, Ecto.Date
    embeds_many :invoice_items, Cart.InvoiceItem

    timestamps
  end

end
