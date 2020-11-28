defmodule Stone.Repo.Migrations.AddAccountsTable do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :balance_in_cents, :integer
      add :user_id, references(:users, type: :uuid, on_delete: :delete_all), null: false
      timestamps()
    end
  end
end
