defmodule DbmsProject3.Consultations do
  @moduledoc """
  The Consultations context.
  """

  import Ecto.Query, warn: false
  alias DbmsProject3.Repo

  alias DbmsProject3.Consultations.Consultation

  @doc """
  Returns the list of consultations.

  ## Examples

      iex> list_consultations()
      [%Consultation{}, ...]

  """
  def list_consultations do
    Repo.all(Consultation)
  end

  @doc """
  Gets a single consultation.

  Raises `Ecto.NoResultsError` if the Consultation does not exist.

  ## Examples

      iex> get_consultation!(123)
      %Consultation{}

      iex> get_consultation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_consultation!(id), do: Repo.get!(Consultation, id)

  @doc """
  Creates a consultation.

  ## Examples

      iex> create_consultation(%{field: value})
      {:ok, %Consultation{}}

      iex> create_consultation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_consultation(attrs \\ %{}) do
    %Consultation{}
    |> Consultation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a consultation.

  ## Examples

      iex> update_consultation(consultation, %{field: new_value})
      {:ok, %Consultation{}}

      iex> update_consultation(consultation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_consultation(%Consultation{} = consultation, attrs) do
    consultation
    |> Consultation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a consultation.

  ## Examples

      iex> delete_consultation(consultation)
      {:ok, %Consultation{}}

      iex> delete_consultation(consultation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_consultation(%Consultation{} = consultation) do
    Repo.delete(consultation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking consultation changes.

  ## Examples

      iex> change_consultation(consultation)
      %Ecto.Changeset{data: %Consultation{}}

  """
  def change_consultation(%Consultation{} = consultation, attrs \\ %{}) do
    Consultation.changeset(consultation, attrs)
  end
end
