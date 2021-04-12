defmodule DbmsProject3.Repo.Migrations.StudentToGroup do
  use Ecto.Migration

  def change do
    alter table(:students) do
      add :group_id, references(:groups, on_delete: :nothing)
    end
    create index(:students, [:group_id])
  end
end
