defmodule TeamChats.Chat.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :name, :string
    belongs_to :created_by, TeamChats.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:name, :created_by_id])
    |> validate_required([:name, :created_by_id])
  end
end
