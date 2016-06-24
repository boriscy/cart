defmodule Cart.Invoice do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Cart.{Invoice, InvoiceItem, Item, Repo}

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "invoices" do
    field :customer, :string
    field :amount, :decimal, precision: 12, scale: 2
    field :balance, :decimal, precision: 12, scale: 2
    field :date, Ecto.Date
    has_many :invoice_items, InvoiceItem, on_delete: :delete_all

    timestamps
  end

  @fields ~w(customer amount balance date)

  def changeset(data, params \\ %{}) do
    data
    |> cast(params, @fields)
    |> validate_required([:customer, :date])
  end

  def create(params) do
    cs = changeset(%Invoice{}, params)
    |> validate_item_count(params)
    |> put_assoc(:invoice_items, get_items(params))

    if cs.valid? do
      Repo.insert(cs)
    else
      cs
    end
  end

  defp get_items(params) do
    items = items_with_prices(params[:invoice_items] || params["invoice_items"])
    Enum.map(items, fn(item)-> InvoiceItem.changeset(%InvoiceItem{}, item) end)
  end

  defp items_with_prices(items) do
    item_ids = Enum.map(items, fn(item) -> item[:item_id] || item["item_id"] end)
    q = from(i in Item, select: %{id: i.id, price: i.price}, where: i.id in ^item_ids)
    prices = Repo.all(q)

    Enum.map(items, fn(item) ->
      item_id = item[:item_id] || item["item_id"]
      %{
         item_id: item_id,
         quantity: item[:quantity] || item["quantity"],
         price: Enum.find(prices, fn(p) -> p[:id] == item_id end)[:price] || 0
       }
    end)
  end


  defp validate_item_count(cs, params) do
    items = params[:invoice_items] || params["invoice_items"]

    if Enum.count(items) <= 0 do
      add_error(cs, :invoice_items, "Invalid number of items")
    else
      cs
    end
  end

end
