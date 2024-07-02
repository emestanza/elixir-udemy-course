defmodule DiscussWeb.Models.User do
  use DiscussWeb, :model
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:email]}

  schema "users" do
    field(:email, :string)
    field(:provider, :string)
    field(:token, :string)
    has_many(:topics, DiscussWeb.Models.Topic)
    has_many(:comments, DiscussWeb.Models.Comment)
    timestamps()
  end

  @doc false
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
end
