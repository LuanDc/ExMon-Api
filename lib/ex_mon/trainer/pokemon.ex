defmodule ExMon.Trainer.Pokemon do
  use Ecto.Schema
  import Ecto.Changeset

  alias ExMon.Trainer

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "pokemons" do
    field :name, :string
    field :nickname, :string
    field :weight, :integer
    field :types, {:array, :string}
    belongs_to(:trainer, Trainer)
    timestamps()
  end

  @requires_params [:name, :nickname, :weight, :types, :trainer_id]

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @requires_params)
    |> validate_required(@requires_params)
    |> assoc_constraint(:trainer)
    |> validate_length(:nickname, min: 2)
  end

  def update_changeset(pokemons, params) do
    pokemons
    |> cast(params, [:nickname])
    |> validate_required([:nickname])
    |> validate_length(:nickname, min: 2)
  end
end
