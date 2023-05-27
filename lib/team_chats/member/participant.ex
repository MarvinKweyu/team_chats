defmodule TeamChats.Member.Participant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "participants" do
    belongs_to :user, TeamChats.Accounts.User
    belongs_to :room, TeamChats.Chat.Room
    field :joined_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(participant, attrs) do
    participant
    |> cast(attrs, [:joined_at])
    |> validate_required([:joined_at])
  end
end
