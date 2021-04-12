defmodule DbmsProject3.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :number, :integer

      timestamps()
    end

  end
end
