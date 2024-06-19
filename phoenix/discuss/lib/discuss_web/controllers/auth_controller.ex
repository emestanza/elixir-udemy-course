defmodule DiscussWeb.AuthController do
  alias DiscussWeb.Models.User
  alias Discuss.Repo

  use DiscussWeb, :controller

  require Logger

  plug(Ueberauth)

  def request(conn, %{"provider" => provider}) do
    conn
    |> Ueberauth.request(provider, conn.host <> "/auth/#{provider}/callback")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    IO.puts("Failed to authenticate => #{inspect(conn)}")

    user_params = %{
      email: auth.info.email,
      provider: Atom.to_string(auth.provider),
      token: auth.credentials.token
    }

    Logger.info("USER PARAMS => #{inspect(user_params)}")

    changeset = User.changeset(%User{}, user_params)

    signin(conn, changeset)
  end

  def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> put_flash(:info, "Signed out successfully")
    |> redirect(to: "/")
  end

  defp signin(conn, changeset) do
    res = upsert(changeset)
    Logger.info("UPSERT CHANGES => #{inspect(res)}")

    case res do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Signed in successfully")
        |> put_session(:user_id, user.id)
        |> redirect(to: "/")

      _ ->
        conn
        |> put_flash(:error, "Failed to sign in")
        |> redirect(to: "/")
    end
  end

  defp upsert(changeset) do
    Repo.get_by(User, email: changeset.changes.email)
    |> case do
      nil -> Repo.insert(changeset)
      user -> {:ok, user}
    end
  end
end
