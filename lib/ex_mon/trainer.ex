defmodule ExMon.Trainer do
  use Ecto.Schema
  import Ecto.Changeset

  alias ExMon.Trainer.Pokemon

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  @requires_params [:name, :password]

  schema "trainers" do
    field :name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    has_many(:pokemon, Pokemon)
    timestamps()
  end

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params), do: create_changeset(%__MODULE__{}, params)

  def changeset(params, trainer),
    do: create_changeset(trainer, params)

  defp create_changeset(module_or_trainer, params) do
    module_or_trainer
    |> cast(params, @requires_params)
    |> validate_required(@requires_params)
    |> validate_length(:password, min: 6)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset),
    do: change(changeset, Argon2.add_hash(password))

  defp put_pass_hash(changeset),
    do: changeset
end
