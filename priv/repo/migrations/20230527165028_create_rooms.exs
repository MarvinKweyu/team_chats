defmodule TeamChats.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string
      add :created_by_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:rooms, [:created_by_id])
  end
end
