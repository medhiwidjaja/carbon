defmodule CarbonWeb.PageLiveTest do
  use CarbonWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Carbon Intensity"
    assert render(page_live) =~ "Carbon Intensity"
  end
end
