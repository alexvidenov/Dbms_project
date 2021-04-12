defmodule DbmsProject3.Groups.Group do
  use Ecto.Schema
  import Ecto.Changeset

  alias DbmsProject3.Students.Student

  schema "groups" do
    field :number, :integer

    has_many :students, Student

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:number])
    |> validate_required([:number])
  end
end
