defmodule LiveViewTodosWeb.TodoLive do
  use Phoenix.LiveView

  alias LiveViewTodos.Todos
  alias LiveViewTodosWeb.TodoView

  # LiveView is a module with 3 callback functions:
  #        1. mount()
  #        2. handle_event()
  #        3. render()

  # assigns the initial state of the LiveView process
  def mount(_session, socket) do
    {:ok, fetch(socket)}
  end

  # changes the state of the process
  def handle_event("add", %{"todo" => todo}, socket) do
    Todos.create_todo(todo)

    {:noreply, fetch(socket)}
  end

  # changes the state of the process
  def handle_event("toggle_done", id, socket) do
    todo = Todos.get_todo!(id)

    Todos.update_todo(todo, %{done: !todo.done})
    {:noreply, fetch(socket)}
  end

  # renders a new view for the newly updated state
  def render(assigns) do
    TodoView.render("todos.html", assigns)
  end

  defp fetch(socket) do
    assign(socket, todos: Todos.list_todos())
  end
end
