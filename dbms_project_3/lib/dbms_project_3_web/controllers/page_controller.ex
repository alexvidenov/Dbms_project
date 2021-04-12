defmodule DbmsProject3Web.PageController do
  use DbmsProject3Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
