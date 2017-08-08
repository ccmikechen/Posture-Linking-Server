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
end
