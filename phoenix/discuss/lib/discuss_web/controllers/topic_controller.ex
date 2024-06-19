defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller
  use DiscussWeb, :model

  alias DiscussWeb.Models.Topic
  alias Discuss.Repo

  plug(DiscussWeb.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete])
  plug(:check_topic_owner when action in [:edit, :update, :delete])

  require Logger
  def init(options), do: options

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

    changeset =
      conn.assigns[:user]
      |> build_assoc(:topics)
      |> Topic.changeset(topic)

    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Topic created successfully")
        |> redirect(to: ~p"/")

      {:error, changeset} ->
        render(conn, :new, layout: {DiscussWeb.Layouts, "app.html"}, changeset: changeset)
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get!(Topic, topic_id)
    changeset = Topic.changeset(topic)

    render(conn, :edit,
      layout: {DiscussWeb.Layouts, "app.html"},
      topic: topic,
      changeset: changeset,
      topic_id: topic_id
    )
  end

  def update(conn, %{"topic" => topic_edited, "id" => topic_id} = params) do
    old_topic = Repo.get!(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic_edited)

    case Repo.update(changeset) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic updated successfully")
        |> redirect(to: ~p"/")

      {:error, changeset} ->
        render(conn, :edit,
          layout: {DiscussWeb.Layouts, "app.html"},
          topic: topic_edited,
          changeset: changeset,
          topic_id: topic_id
        )
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    topic = Repo.get!(Topic, topic_id)
    Repo.delete!(topic)

    conn
    |> put_flash(:info, "Topic deleted successfully")
    |> redirect(to: ~p"/")
  end

  def check_topic_owner(conn, _params) do
    topic_id = conn.params["id"]
    topic = Repo.get!(Topic, topic_id)
    user = conn.assigns[:user]

    if topic.user_id != user.id do
      conn
      |> put_flash(:error, "You are not the owner of this topic")
      |> redirect(to: ~p"/")
    else
      conn
    end
  end
end
