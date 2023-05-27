defmodule TeamChats.Repo.Migrations.CreateParticipants do
  use Ecto.Migration

  def change do
    create table(:participants) do
      add :user_id, references(:users, on_delete: :nothing)
      add :room_id, references(:rooms, on_delete: :nothing)
      add :joined_at, :utc_datetime

      timestamps()
    end

    create index(:participants, [:user_id])
    create index(:participants, [:room_id])
  end
end
