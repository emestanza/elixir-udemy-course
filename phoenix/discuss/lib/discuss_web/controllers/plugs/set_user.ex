defmodule DiscussWeb.Plugs.SetUser do
  alias ElixirSense.Plugins.Phoenix
  import Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)

    cond do
      user = user_id && Discuss.Repo.get(DiscussWeb.Models.User, user_id) ->
        assign(conn, :user, user)

      true ->
        assign(conn, :user, nil)
    end
  end
end
