defmodule DiscussWeb.Models.Comment do
  use DiscussWeb, :model
  import Ecto.Changeset

  schema "comments" do
    field(:content, :string)
    belongs_to(:user, DiscussWeb.Models.User)
    belongs_to(:topic, DiscussWeb.Models.Topic)
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end
