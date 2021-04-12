defmodule DbmsProject3.Repo.Migrations.StudentTask do
  use Ecto.Migration

  def change do
    alter table(:students) do
      add :project_id, references(:projects, on_delete: :nothing)
    end
  end
end
