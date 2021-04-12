defmodule DbmsProject3.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :fac_number, :integer
      add :first_name, :string
      add :middle_name, :string
      add :last_name, :string
      add :studying_year, :string
      add :form_of_education, :string
      add :certified_semester, :integer

      timestamps()
    end

  end
end
