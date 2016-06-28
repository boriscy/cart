defmodule Cart.Item do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Cart.{InvoiceItem, Item, Repo}

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "items" do
    field :name, :string
    field :price, :decimal, precision: 12, scale: 2
    has_many :invoice_items, InvoiceItem

    timestamps
  end

  @fields ~w(name price)

  def changeset(data, params \\ %{}) do
    data
    |> cast(params, @fields)
    |> validate_required([:name, :price])
    |> validate_number(:price, greater_than_or_equal_to: Decimal.new(0))
  end

  def items_by_quantity, do: Repo.all items_by(:quantity)

  def items_by_subtotal, do: Repo.all items_by(:subtotal)

  defp items_by(type) do
    from i in Item,
    join: ii in InvoiceItem, on: ii.item_id == i.id,
    select: %{id: i.id, name: i.name, total: sum(field(ii, ^type))},
    group_by: i.id,
    order_by: [desc: sum(field(ii, ^type))]
  end

end
