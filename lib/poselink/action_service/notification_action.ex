defmodule Poselink.ActionService.NotificationAction do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, nil, [name: __MODULE__])
  end

  def execute(payload, config) do
    GenServer.cast(__MODULE__, {:execute, payload, config})
  end

  # Server

  def handle_cast({:execute, payload, config}, state) do
    [api_key: key] = Application.get_env(:poselink, __MODULE__)

    token = "cszs5WH4q_g:APA91bFagVHgHdN3KV4oivAGE_kXt_ROGgCVSWWajsOwdj-4khI1uuu-jB3iYmIHjGFaQetB-C1VFVkaInvkDhtCzPWwjmemecqQ1egKeHcpmBP8hRrZ0eaun0Kg8-N8b83oDMJ8peI4"

    GCM.push(key, [token],
      %{notification: %{
          title: "hi",
          body: "yo",
          message: "hi",
          sound: "default",
          icon: "default",
          color: "#FFFFFF"
        },
        data: %{
          message: "hi"
        }
      }
    )

    {:noreply, state}
  end

end
