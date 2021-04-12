defmodule DbmsProject3Web.StudentView do
  use DbmsProject3Web, :view

  alias DbmsProject3Web.ProjectView

  def groups_for_select(groups) do
    groups
    |> Enum.map(&["#{&1.number}": &1.id])
    |> List.flatten()
  end

  def levels_for_select(levels) do
    levels
    |> Enum.map(&["#{&1.name}": &1.id])
    |> List.flatten()
  end
end
