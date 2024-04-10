defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias DiscussWeb.Models.Topic

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render(conn, :new, layout: {DiscussWeb.Layouts, "app.html"}, changeset: changeset)
  end

  def create(conn, %{"topic" => topic} = params) do
    IO.inspect(params)

    changeset = Topic.changeset(%Topic{}, %{})

    render(conn, :new, layout: {DiscussWeb.Layouts, "app.html"}, changeset: changeset)
  end
end
