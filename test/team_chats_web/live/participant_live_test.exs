defmodule TeamChatsWeb.ParticipantLiveTest do
  use TeamChatsWeb.ConnCase

  import Phoenix.LiveViewTest
  import TeamChats.MemberFixtures

  @create_attrs %{joined_at: "2023-05-26T17:42:00Z"}
  @update_attrs %{joined_at: "2023-05-27T17:42:00Z"}
  @invalid_attrs %{joined_at: nil}

  defp create_participant(_) do
    participant = participant_fixture()
    %{participant: participant}
  end

  describe "Index" do
    setup [:create_participant]

    test "lists all participants", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/participants")

      assert html =~ "Listing Participants"
    end

    test "saves new participant", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/participants")

      assert index_live |> element("a", "New Participant") |> render_click() =~
               "New Participant"

      assert_patch(index_live, ~p"/participants/new")

      assert index_live
             |> form("#participant-form", participant: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#participant-form", participant: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/participants")

      html = render(index_live)
      assert html =~ "Participant created successfully"
    end

    test "updates participant in listing", %{conn: conn, participant: participant} do
      {:ok, index_live, _html} = live(conn, ~p"/participants")

      assert index_live |> element("#participants-#{participant.id} a", "Edit") |> render_click() =~
               "Edit Participant"

      assert_patch(index_live, ~p"/participants/#{participant}/edit")

      assert index_live
             |> form("#participant-form", participant: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#participant-form", participant: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/participants")

      html = render(index_live)
      assert html =~ "Participant updated successfully"
    end

    test "deletes participant in listing", %{conn: conn, participant: participant} do
      {:ok, index_live, _html} = live(conn, ~p"/participants")

      assert index_live
             |> element("#participants-#{participant.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#participants-#{participant.id}")
    end
  end

  describe "Show" do
    setup [:create_participant]

    test "displays participant", %{conn: conn, participant: participant} do
      {:ok, _show_live, html} = live(conn, ~p"/participants/#{participant}")

      assert html =~ "Show Participant"
    end

    test "updates participant within modal", %{conn: conn, participant: participant} do
      {:ok, show_live, _html} = live(conn, ~p"/participants/#{participant}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Participant"

      assert_patch(show_live, ~p"/participants/#{participant}/show/edit")

      assert show_live
             |> form("#participant-form", participant: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#participant-form", participant: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/participants/#{participant}")

      html = render(show_live)
      assert html =~ "Participant updated successfully"
    end
  end
end
