defmodule CarbonWeb.IntensityLive.Index do
  use CarbonWeb, :live_view

  alias Carbon.Measure

  def mount(_session, socket) do
    {:ok, assign(socket, conn: socket)}
  end

  @impl true
  def handle_params(%{"page" => page}, _url, socket) do
    IO.puts("#{page} *********")
    assigns = get_and_assign_page(page)
    {:noreply, assign(socket, assigns)}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    assigns = get_and_assign_page(nil)
    {:noreply, assign(socket, assigns)}
  end

  def get_and_assign_page(page_number) do
    %{
      entries: entries,
      page_number: page_number,
      page_size: page_size,
      total_entries: total_entries,
      total_pages: total_pages
    } = Measure.paginate_intensities(page: page_number)

    [
      intensities: entries,
      page_number: page_number,
      page_size: page_size,
      total_entries: total_entries,
      total_pages: total_pages
    ]
  end

  @impl true
  def handle_event("nav", %{"page" => page}, socket) do
    {:noreply,
     push_redirect(socket,
       to: Routes.intensity_index_path(socket, :index, page: page)
     )}
  end
end
