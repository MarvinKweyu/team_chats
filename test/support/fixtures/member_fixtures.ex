defmodule TeamChats.MemberFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TeamChats.Member` context.
  """

  @doc """
  Generate a participant.
  """
  def participant_fixture(attrs \\ %{}) do
    {:ok, participant} =
      attrs
      |> Enum.into(%{
        joined_at: ~U[2023-05-26 17:42:00Z]
      })
      |> TeamChats.Member.create_participant()

    participant
  end
end
