defmodule DbmsProject3.ProjectMarks do
  import Ecto.Query, warn: false
  alias DbmsProject3.Repo

  alias DbmsProject3.ProjectMarks.Mark

  def list_marks do
    Repo.all(Mark)
  end

  def get_mark!(id), do: Repo.get!(Mark, id)

  def get_mark_assoc!(id), do: Mark |> Repo.get!(id) |> Repo.preload(:project)

  def create_mark(attrs \\ %{}, average) do
    %Mark{total_mark: average}
    |> Mark.changeset(attrs)
    |> Repo.insert()
  end

  def update_mark(%Mark{} = mark, attrs) do
    mark
    |> Mark.changeset(attrs)
    |> Repo.update()
  end

  def delete_mark(%Mark{} = mark) do
    Repo.delete(mark)
  end

  def change_mark(%Mark{} = mark, attrs \\ %{}) do
    Mark.changeset(mark, attrs)
  end
end
