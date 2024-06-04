defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller
  # use DiscussWeb, :html
  # use DiscussWeb, :model

  alias DiscussWeb.Models.Topic
  alias Discuss.Repo

  def index(conn, _params) do
    topics = Repo.all(Topic)

    render(conn, :index, layout: {DiscussWeb.Layouts, "app.html"}, topics: topics)
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render(conn, :new, layout: {DiscussWeb.Layouts, "app.html"}, changeset: changeset)
  end

  def create(conn, %{"topic" => topic} = params) do
    IO.inspect(params)

    changeset = Topic.changeset(%Topic{}, topic)

    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Topic created successfully")
        |> redirect(to: ~p"/")

      {:error, changeset} ->
        render(conn, :new, layout: {DiscussWeb.Layouts, "app.html"}, changeset: changeset)
    end
  end
end
