defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

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
end
