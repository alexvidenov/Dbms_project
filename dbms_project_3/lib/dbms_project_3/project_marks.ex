defmodule DbmsProject3.ProjectMarks do
  @moduledoc """
  The ProjectMarks context.
  """

  import Ecto.Query, warn: false
  alias DbmsProject3.Repo

  alias DbmsProject3.ProjectMarks.Mark

  @doc """
  Returns the list of marks.

  ## Examples

      iex> list_marks()
      [%Mark{}, ...]

  """
  def list_marks do
    Repo.all(Mark)
  end

  @doc """
  Gets a single mark.

  Raises `Ecto.NoResultsError` if the Mark does not exist.

  ## Examples

      iex> get_mark!(123)
      %Mark{}

      iex> get_mark!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mark!(id), do: Repo.get!(Mark, id)

  def get_mark_assoc!(id), do: Mark |> Repo.get!(id) |> Repo.preload(:project)

  @doc """
  Creates a mark.

  ## Examples

      iex> create_mark(%{field: value})
      {:ok, %Mark{}}

      iex> create_mark(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mark(attrs \\ %{}) do
    %Mark{}
    |> Mark.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mark.

  ## Examples

      iex> update_mark(mark, %{field: new_value})
      {:ok, %Mark{}}

      iex> update_mark(mark, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mark(%Mark{} = mark, attrs) do
    mark
    |> Mark.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a mark.

  ## Examples

      iex> delete_mark(mark)
      {:ok, %Mark{}}

      iex> delete_mark(mark)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mark(%Mark{} = mark) do
    Repo.delete(mark)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mark changes.

  ## Examples

      iex> change_mark(mark)
      %Ecto.Changeset{data: %Mark{}}

  """
  def change_mark(%Mark{} = mark, attrs \\ %{}) do
    Mark.changeset(mark, attrs)
  end
end
