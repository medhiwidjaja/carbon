defmodule CarbonWeb.Shared.SidebarComponent do
  use CarbonWeb, :live_component

  def render(assigns) do
    ~L"""
      <div class="min-h-screen flex flex-row bg-gray-200">
        <div class="flex flex-col w-56 rounded-r-3xl overflow-hidden">
          <div class="flex items-center justify-center h-20">
            <h1 class="text-2xl">Carbon Intensity</h1>
          </div>
          <ul class="flex flex-col py-4">
            <li>
              <a href="/" class="flex flex-row items-center h-12 transform hover:translate-x-2 transition-transform ease-in duration-200 text-gray-500 hover:text-gray-800">
                <span class="inline-flex items-center justify-center h-12 w-12 text-lg text-gray-400"><i class="bx bx-home"></i></span>
                <span class="text-sm font-medium">Dashboard</span>
              </a>
            </li>
            <li>
              <a href="/table" class="flex flex-row items-center h-12 transform hover:translate-x-2 transition-transform ease-in duration-200 text-gray-500 hover:text-gray-800">
                <span class="inline-flex items-center justify-center h-12 w-12 text-lg text-gray-400"><i class="bx bx-home"></i></span>
                <span class="text-sm font-medium">Table</span>
              </a>
            </li>
            <li>
              <a href="/chart" class="flex flex-row items-center h-12 transform hover:translate-x-2 transition-transform ease-in duration-200 text-gray-500 hover:text-gray-800">
                <span class="inline-flex items-center justify-center h-12 w-12 text-lg text-gray-400"><i class="bx bx-home"></i></span>
                <span class="text-sm font-medium">Chart</span>
              </a>
            </li>
          </ul>
        </div>
      </div>
    """
  end
end
