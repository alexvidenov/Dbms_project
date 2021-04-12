defmodule DbmsProject3.StudentProjects.Project do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias DbmsProject3.Consultations.Consultation
  alias DbmsProject3.ProjectMarks.Mark
  alias DbmsProject3.Students.Student

  schema "projects" do
    field :annual_production_program, :integer
    field :classifier, :string
    field :notes, :string
    field :project_defending_date, :date
    field :task_given_date, :date
    field :topic, :string

    has_many :consultations, Consultation
    has_one :marks, Mark
    belongs_to :student, Student

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [
      :classifier,
      :topic,
      :annual_production_program,
      :task_given_date,
      :project_defending_date,
      :notes,
      :student_id
    ])
    |> validate_required([
      :classifier,
      :topic,
      :annual_production_program,
      :task_given_date,
      :project_defending_date
    ])
  end

  def search(query, search_term) do
    wildcard_search = "%#{search_term}%"

    from project in query,
      where: ilike(project.classifier, ^wildcard_search),
      or_where: ilike(project.topic, ^wildcard_search)
  end
end
