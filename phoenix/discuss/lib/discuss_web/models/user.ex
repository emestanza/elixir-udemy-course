defmodule DiscussWeb.Models.User do
  #use Ecto.Schema
  #import Ecto.Changeset
  use DiscussWeb, :model

  schema "users" do
    field(:email, :string)
    field(:provider, :string)
    field(:token, :string)
    has_many(:topics, DiscussWeb.Models.Topic)
    timestamps()
  end

  @doc false
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
end
