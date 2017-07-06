defmodule Poselink.PostureChannel do
  use Poselink.Web, :channel

  import Guardian.Phoenix.Socket

  def join("posture:record", %{"guardian_token" => token}, socket) do
    case sign_in(socket, token) do
      {:ok, authed_socket , _guardian_params} ->
        {:ok, %{message: "Joined"}, authed_socket}
      {:error, reason} ->
        {:error, %{reason: reason}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", _payload, socket) do
    user = current_resource(socket)
    broadcast(socket, "pong", %{message: "pong", from: user.username})
    {:noreply, socket}
  end

  def handle_in("start", config, socket) do

  end

  def handle_in("new_data", data, socket) do

  end

  def handle_in("save", _payload, socket) do

  end
end
