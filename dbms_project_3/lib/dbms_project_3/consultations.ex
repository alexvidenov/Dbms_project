defmodule DbmsProject3.Consultations do
  import Ecto.Query, warn: false
  alias DbmsProject3.Repo

  alias DbmsProject3.Consultations.Consultation

  def list_consultations do
    Repo.all(Consultation)
  end

  def get_consultation!(id), do: Repo.get!(Consultation, id)

  def create_consultation(attrs \\ %{}) do
    %Consultation{}
    |> Consultation.changeset(attrs)
    |> Repo.insert()
  end

  def update_consultation(%Consultation{} = consultation, attrs) do
    consultation
    |> Consultation.changeset(attrs)
    |> Repo.update()
  end

  def delete_consultation(%Consultation{} = consultation) do
    Repo.delete(consultation)
  end

  def change_consultation(%Consultation{} = consultation, attrs \\ %{}) do
    Consultation.changeset(consultation, attrs)
  end
end
