defmodule DbmsProject3.ProjectMarks.Mark do
  use Ecto.Schema
  import Ecto.Changeset

  alias DbmsProject3.StudentProjects.Project

  schema "marks" do
    field :final_mark, :integer
    field :mark_1, :integer
    field :mark_2, :integer
    field :mark_3, :integer
    field :mark_4, :integer
    field :mark_5, :integer
    field :total_mark, :float

    belongs_to :project, Project

    timestamps()
  end

  @doc false
  def changeset(mark, attrs) do
    mark
    |> cast(attrs, [
      :mark_1,
      :mark_2,
      :mark_3,
      :mark_4,
      :mark_5,
      :total_mark,
      :final_mark,
      :project_id
    ])
    |> validate_required([:mark_1, :mark_2, :mark_3, :mark_4, :mark_5, :total_mark, :final_mark])
  end
end
