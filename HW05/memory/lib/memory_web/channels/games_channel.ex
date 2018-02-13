defmodule MemoryWeb.GamesChannel do
  use MemoryWeb, :channel

  alias Memory.Game

  def join("games:" <> name, payload, socket) do
    if authorized?(payload) do
      #backup code
      game = Memory.GameBackup.load(name) || Game.new()
      socket = socket
      |> assign(:game, game)
      |> assign(:name, name)
      {:ok, %{"join" => name, "game" => Game.client_view(game)}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the clien

  def handle_in("reset", payload, socket) do
    game = Game.new()
    #backup code
    Memory.GameBackup.save(socket.assigns[:name], game)
    socket = assign(socket, :game, game)
    {:reply, {:ok, %{"game" => Game.client_view(game)}}, socket}
  end

  def handle_in("squareClick", payload, socket) do
    game = socket.assigns[:game]
    id = payload["id"]
    currentSquare = payload["currentSquare"]
    flipped = payload["flipped"]
    count = payload["count"]
    locked = payload["locked"]
    matches = payload["matches"]
    result = Game.checkMatch(game, id, currentSquare, flipped, count, locked, matches)
    #backup code
    Memory.GameBackup.save(socket.assigns[:name], result)
    socket = assign(socket, :game, result)
    if !result.locked do
    {:reply, {:ok, %{"game" => Game.client_view(result)}}, socket}
    else
      {:reply, {:done, %{"game" => Game.client_view(result)}}, socket}
    end
  end

  def handle_in("to", payload, socket) do
    game = socket.assigns[:game]
    currentSquare = payload["currentSquare"]
    prevSquareid = payload["prevSquareid"]
    result = Game.handleto(game, currentSquare, prevSquareid)
    #backup code
    Memory.GameBackup.save(socket.assigns[:name], result)
    socket = assign(socket, :game, result)
    {:reply, {:ok, %{"game" => Game.client_view(result)}}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (games:lobby).
  # def handle_in("shout", payload, socket) do
  #   broadcast socket, "shout", payload
  #   {:noreply, socket}
  # end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
