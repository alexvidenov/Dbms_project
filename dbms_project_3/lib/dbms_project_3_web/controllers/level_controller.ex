defmodule DbmsProject3Web.LevelController do
  use DbmsProject3Web, :controller

  alias DbmsProject3.EducationLevels
  alias DbmsProject3.EducationLevels.Level

  def index(conn, _params) do
    levels = EducationLevels.list_levels()
    render(conn, "index.html", levels: levels)
  end

  def new(conn, _params) do
    changeset = EducationLevels.change_level(%Level{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"level" => level_params}) do
    case EducationLevels.create_level(level_params) do
      {:ok, level} ->
        conn
        |> put_flash(:info, "Level created successfully.")
        |> redirect(to: Routes.level_path(conn, :show, level))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    level = EducationLevels.get_level!(id)
    render(conn, "show.html", level: level)
  end

  def edit(conn, %{"id" => id}) do
    level = EducationLevels.get_level!(id)
    changeset = EducationLevels.change_level(level)
    render(conn, "edit.html", level: level, changeset: changeset)
  end

  def update(conn, %{"id" => id, "level" => level_params}) do
    level = EducationLevels.get_level!(id)

    case EducationLevels.update_level(level, level_params) do
      {:ok, level} ->
        conn
        |> put_flash(:info, "Level updated successfully.")
        |> redirect(to: Routes.level_path(conn, :show, level))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", level: level, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    level = EducationLevels.get_level!(id)
    {:ok, _level} = EducationLevels.delete_level(level)

    conn
    |> put_flash(:info, "Level deleted successfully.")
    |> redirect(to: Routes.level_path(conn, :index))
  end
end
