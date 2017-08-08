defmodule Poselink.TriggerChannel do
  use Poselink.Web, :channel

  def join("trigger:" <> user_id, _params, socket) do
    {user_id, _} = Integer.parse(user_id)

    case socket.assigns.user_id do
      ^user_id ->
        {:ok, socket}
      _ ->
        {:error, nil}
    end
  end

  intercept ["trigger"]

  def handle_out("trigger", %{user_id: user_id, combination_id: combination_id, payload: payload}, socket) do
    case socket.assigns.user_id do
      ^user_id ->
        push socket, "trigger", %{combination_id: combination_id, payload: payload}
      _ ->
        :nothing
    end
    {:noreply, socket}
  end
end
