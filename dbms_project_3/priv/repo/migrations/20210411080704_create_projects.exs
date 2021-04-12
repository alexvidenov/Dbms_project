defmodule DbmsProject3.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :classifier, :string
      add :topic, :string
      add :annual_production_program, :integer
      add :task_given_date, :date
      add :project_defending_date, :date
      add :notes, :string
      add :student_id, references(:students, on_delete: :nothing)

      timestamps()
    end

    create index(:projects, [:student_id])
  end
end
