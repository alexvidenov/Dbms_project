defmodule DbmsProject3.Repo.Migrations.RemoveProjectId do
  use Ecto.Migration

  def change do
    alter table(:students) do
      remove :project_id
    end
  end
end
