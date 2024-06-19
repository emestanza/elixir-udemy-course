defmodule DiscussWeb.Plugs.RequireAuth do

  import Plug.Conn
  import Phoenix.Controller

  def init(default), do: default

  def call(conn, _default) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access this page")
      |> redirect(to: "/")
      |> halt
    end
  end
end
