defmodule TeamChats.Repo do
  use Ecto.Repo,
    otp_app: :team_chats,
    adapter: Ecto.Adapters.Postgres
end
