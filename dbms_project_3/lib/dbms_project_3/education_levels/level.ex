defmodule DbmsProject3.EducationLevels.Level do
  use Ecto.Schema
  import Ecto.Changeset

  alias DbmsProject3.Students.Student

  schema "levels" do
    field :name, :string

    has_many :students, Student

    timestamps()
  end

  @doc false
  def changeset(level, attrs) do
    level
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
