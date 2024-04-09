defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  def new(conn, _params) do
    render(conn, :home, layout: {DiscussWeb.Layouts, "root.html"})
  end
end
