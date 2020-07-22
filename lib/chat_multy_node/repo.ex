defmodule ChatMultyNode.Repo do
  use Ecto.Repo,
    otp_app: :chat_multy_node,
    adapter: Ecto.Adapters.Postgres
end
