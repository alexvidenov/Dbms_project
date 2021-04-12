defmodule DbmsProject3.Repo.Migrations.StudentToLevel do
  use Ecto.Migration

  def change do
    alter table(:students) do
      add :level_id, references(:levels, on_delete: :nothing)
    end
    create index(:students, [:level_id])
  end
end
