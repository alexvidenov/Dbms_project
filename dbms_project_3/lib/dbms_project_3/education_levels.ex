defmodule DbmsProject3.EducationLevels do
  import Ecto.Query, warn: false
  alias DbmsProject3.Repo

  alias DbmsProject3.EducationLevels.Level

  def list_levels do
    Repo.all(Level)
  end

  def get_level!(id), do: Repo.get!(Level, id)

  def create_level(attrs \\ %{}) do
    %Level{}
    |> Level.changeset(attrs)
    |> Repo.insert()
  end

  def update_level(%Level{} = level, attrs) do
    level
    |> Level.changeset(attrs)
    |> Repo.update()
  end

  def delete_level(%Level{} = level) do
    Repo.delete(level)
  end

  def change_level(%Level{} = level, attrs \\ %{}) do
    Level.changeset(level, attrs)
  end
end
