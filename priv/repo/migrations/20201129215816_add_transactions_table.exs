defmodule Stone.Repo.Migrations.AddTransactionsTable do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :description, :string
      add :nature, :string
      add :amount_in_cents, :integer
      add :account_id, references(:accounts, type: :uuid), null: false
      add :transaction_hash, :string
      timestamps()
    end
  end
end
