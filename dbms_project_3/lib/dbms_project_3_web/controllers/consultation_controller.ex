defmodule DbmsProject3Web.ConsultationController do
  use DbmsProject3Web, :controller

  alias DbmsProject3.Consultations
  alias DbmsProject3.Consultations.Consultation
  alias DbmsProject3.StudentProjects.Project

  def index(conn, _params) do
    consultations = Consultations.list_consultations()
    render(conn, "index.html", consultations: consultations)
  end

  def new(conn, %{"project_id" => id}) do
    changeset = Consultations.change_consultation(%Consultation{})
    render(conn, "new.html", changeset: changeset, project_id: id)
  end

  def create(conn, %{"consultation" => consultation_params}) do
    case Consultations.create_consultation(consultation_params) do
      {:ok, consultation} ->
        conn
        |> put_flash(:info, "Consultation created successfully.")
        |> redirect(to: Routes.project_path(conn, :show, %Project{id: consultation.project_id}))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    consultation = Consultations.get_consultation!(id)
    render(conn, "show.html", consultation: consultation)
  end

  def edit(conn, %{"id" => id}) do
    consultation = Consultations.get_consultation!(id)
    changeset = Consultations.change_consultation(consultation)
    render(conn, "edit.html", consultation: consultation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "consultation" => consultation_params}) do
    consultation = Consultations.get_consultation!(id)

    case Consultations.update_consultation(consultation, consultation_params) do
      {:ok, consultation} ->
        conn
        |> put_flash(:info, "Consultation updated successfully.")
        |> redirect(to: Routes.consultation_path(conn, :show, consultation))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", consultation: consultation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    consultation = Consultations.get_consultation!(id)
    {:ok, _consultation} = Consultations.delete_consultation(consultation)

    conn
    |> put_flash(:info, "Consultation deleted successfully.")
    |> redirect(to: Routes.consultation_path(conn, :index))
  end
end
