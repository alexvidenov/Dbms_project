defmodule DbmsProject3.Consultations.Consultation do
  use Ecto.Schema
  import Ecto.Changeset

  alias DbmsProject3.StudentProjects.Project

  schema "consultations" do
    field :consultation_date, :date

    belongs_to :project, Project

    timestamps()
  end

  @doc false
  def changeset(consultation, attrs) do
    consultation
    |> cast(attrs, [:consultation_date])
    |> validate_required([:consultation_date])
  end
end
