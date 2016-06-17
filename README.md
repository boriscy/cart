# Cart

**TODO: Add description**

## Installation

alias Cart.{Repo, Invoice, InvoiceItem}

inv_items = [%Cart.InvoiceItem{quantity: 2, price: 10.5, subtotal: 21, item_id: "b6467fae-84a7-4746-9bbf-8862524fe9e3"}]
inv_items = List.map(inv_items, fn(it)-> Ecto.Changeset.change(it))
inv = %Cart.Invoice{amount: 10, balance: 10, invoice_items: inv_items}
inv_c = Ecto.Changeset.change(c)
Cart.Repo.insert(inv_c)
