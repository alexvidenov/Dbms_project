defmodule DbmsProject3.Repo.Migrations.CreateMarks do
  use Ecto.Migration

  def change do
    create table(:marks) do
      add :mark_1, :integer
      add :mark_2, :integer
      add :mark_3, :integer
      add :mark_4, :integer
      add :mark_5, :integer
      add :total_mark, :float
      add :final_mark, :integer
      add :project_id, references(:projects, on_delete: :nothing)

      timestamps()
    end

    create index(:marks, [:project_id])
  end
end
