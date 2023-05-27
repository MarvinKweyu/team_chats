defmodule TeamChats.MemberTest do
  use TeamChats.DataCase

  alias TeamChats.Member

  describe "participants" do
    alias TeamChats.Member.Participant

    import TeamChats.MemberFixtures

    @invalid_attrs %{joined_at: nil}

    test "list_participants/0 returns all participants" do
      participant = participant_fixture()
      assert Member.list_participants() == [participant]
    end

    test "get_participant!/1 returns the participant with given id" do
      participant = participant_fixture()
      assert Member.get_participant!(participant.id) == participant
    end

    test "create_participant/1 with valid data creates a participant" do
      valid_attrs = %{joined_at: ~U[2023-05-26 17:42:00Z]}

      assert {:ok, %Participant{} = participant} = Member.create_participant(valid_attrs)
      assert participant.joined_at == ~U[2023-05-26 17:42:00Z]
    end

    test "create_participant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Member.create_participant(@invalid_attrs)
    end

    test "update_participant/2 with valid data updates the participant" do
      participant = participant_fixture()
      update_attrs = %{joined_at: ~U[2023-05-27 17:42:00Z]}

      assert {:ok, %Participant{} = participant} = Member.update_participant(participant, update_attrs)
      assert participant.joined_at == ~U[2023-05-27 17:42:00Z]
    end

    test "update_participant/2 with invalid data returns error changeset" do
      participant = participant_fixture()
      assert {:error, %Ecto.Changeset{}} = Member.update_participant(participant, @invalid_attrs)
      assert participant == Member.get_participant!(participant.id)
    end

    test "delete_participant/1 deletes the participant" do
      participant = participant_fixture()
      assert {:ok, %Participant{}} = Member.delete_participant(participant)
      assert_raise Ecto.NoResultsError, fn -> Member.get_participant!(participant.id) end
    end

    test "change_participant/1 returns a participant changeset" do
      participant = participant_fixture()
      assert %Ecto.Changeset{} = Member.change_participant(participant)
    end
  end
end
