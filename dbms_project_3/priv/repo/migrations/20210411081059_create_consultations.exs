defmodule DbmsProject3.Repo.Migrations.CreateConsultations do
  use Ecto.Migration

  def change do
    create table(:consultations) do
      add :consultation_date, :date
      add :project_id, references(:projects, on_delete: :nothing)

      timestamps()
    end

    create index(:consultations, [:project_id])
  end
end
