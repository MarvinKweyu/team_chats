defmodule TeamChatsWeb.ParticipantLive.Index do
  use TeamChatsWeb, :live_view

  alias TeamChats.Member
  alias TeamChats.Member.Participant

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :participants, Member.list_participants())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Participant")
    |> assign(:participant, Member.get_participant!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Participant")
    |> assign(:participant, %Participant{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Participants")
    |> assign(:participant, nil)
  end

  @impl true
  def handle_info({TeamChatsWeb.ParticipantLive.FormComponent, {:saved, participant}}, socket) do
    {:noreply, stream_insert(socket, :participants, participant)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    participant = Member.get_participant!(id)
    {:ok, _} = Member.delete_participant(participant)

    {:noreply, stream_delete(socket, :participants, participant)}
  end
end
