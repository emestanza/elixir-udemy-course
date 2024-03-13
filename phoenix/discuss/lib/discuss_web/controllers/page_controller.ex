defmodule DiscussWeb.PageController do
  use DiscussWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    #render(conn, :home, layout: {DiscussWeb.Layouts, "root.html"})
    render(conn, :home, layout: false)
  end
end
