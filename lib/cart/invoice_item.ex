defmodule Cart.InvoiceItem do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "invoice_items" do
    field :item_id, :binary_id
    field :quantity, :decimal, precision: 12, scale: 2
    field :price, :decimal, precision: 12, scale: 2
    field :subtotal, :decimal, precision: 12, scale: 2

    timestamps
  end

end
