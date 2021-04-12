defmodule DbmsProject3.Students.Student do
  use Ecto.Schema
  import Ecto.Changeset

  alias DbmsProject3.EducationLevels.Level
  alias DbmsProject3.Groups.Group
  alias DbmsProject3.StudentProjects.Project

  schema "students" do
    field :certified_semester, :integer
    field :fac_number, :integer
    field :first_name, :string
    field :form_of_education, :string
    field :last_name, :string
    field :middle_name, :string
    field :studying_year, :string

    belongs_to :level, Level
    belongs_to :group, Group
    has_one :project, Project

    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [
      :fac_number,
      :first_name,
      :middle_name,
      :last_name,
      :studying_year,
      :form_of_education,
      :certified_semester
    ])
    |> validate_required([
      :fac_number,
      :first_name,
      :middle_name,
      :last_name,
      :studying_year,
      :form_of_education,
      :certified_semester
    ])
  end
end
