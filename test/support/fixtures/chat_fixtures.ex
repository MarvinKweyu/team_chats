defmodule TeamChats.ChatFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TeamChats.Chat` context.
  """

  @doc """
  Generate a room.
  """
  def room_fixture(attrs \\ %{}) do
    {:ok, room} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> TeamChats.Chat.create_room()

    room
  end
end