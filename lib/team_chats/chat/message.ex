defmodule TeamChats.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    belongs_to :user, TeamChats.Accounts.User
    belongs_to :room, TeamChats.Chat.Room
    field :content, :string

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:user_id, :room_id, :content])
    |> validate_required([:user_id, :room_id, :content])
  end
end
