defmodule DiscussWeb.Models.Topic do
  use DiscussWeb, :model
  import Ecto.Changeset

  schema "topics" do
    field(:title, :string)
    belongs_to(:user, DiscussWeb.Models.User)
    has_many(:comments, DiscussWeb.Models.Comment)
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
