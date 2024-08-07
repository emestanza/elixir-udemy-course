defmodule DiscussWeb.CommentsChannel do
  use DiscussWeb, :channel
  use DiscussWeb, :model
  alias Discuss.Repo

  def join("comments:" <> topic_id, _params, socket) do
    topic_id = String.to_integer(topic_id)

    topic =
      DiscussWeb.Models.Topic
      |> Repo.get(topic_id)
      |> Repo.preload(comments: [:user])

    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  def handle_in(name, %{"content" => content}, socket) do
    topic = socket.assigns.topic
    user_id = socket.assigns.user_id

    changeset =
      topic
      |> build_assoc(:comments, user_id: user_id)
      |> DiscussWeb.Models.Comment.changeset(%{content: content})

    case Repo.insert(changeset) do
      {:ok, _comment} ->
        broadcast!(socket, "comments:#{socket.assigns.topic.id}:new", %{content: content})
        {:reply, :ok, socket}

      {:error, _changeset} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end

    {:reply, :ok, socket}
  end
end
