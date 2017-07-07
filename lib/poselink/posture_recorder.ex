defmodule Poselink.PostureRecorder do
  use GenServer

  alias Poselink.Repo
  alias Poselink.User
  alias Poselink.Posture
  alias Poselink.PostureRecord
  alias Poselink.PostureRecordDetail
  alias Poselink.PostureRecordersServer

  def start_link(user_id, config) do
    state = %{
      user_id: user_id,
      config: config,
      data: []
    }
    {:ok, pid} = GenServer.start_link(__MODULE__, state)
    PostureRecordersServer.put_recorder(pid, user_id)

    {:ok, pid}
  end

  def push_data(user_id, data) do
    pid = PostureRecordersServer.get_recorder(user_id)
    GenServer.cast(pid, {:push_data, data})
  end

  def save(user_id) do
    pid = PostureRecordersServer.get_recorder(user_id)
    GenServer.cast(pid, :save)
    GenServer.stop(pid)
    PostureRecordersServer.delete_recorder(user_id)
  end

  def handle_cast({:push_data, data}, state) do
    new_state = %{state | data: [data | state.data]}

    {:noreply, new_state}
  end

  def handle_cast(:save, state) do
    user = Repo.get!(User, state.user_id)
    posture = Repo.get!(Posture, state.config["posture"])

    posture_record =
      %PostureRecord{
        recorder_user_id: user.id,
        posture_id: posture.id,
        height: parseFloat(state.config["height"]),
        weight: parseFloat(state.config["weight"]),
        insole_size: state.config["insoleSize"],
        status: "available"
      }
    inserted_posture_record = Repo.insert!(posture_record)

    state.data
    |> Enum.each(fn data ->
      record_detail =
        %PostureRecordDetail{
          posture_record_id: inserted_posture_record,
          sequence_number: parseFloat(data["sequenceNumber"]),
          left_insole_acc_x: parseFloat(data["insole"]["left"]["x"]),
          left_insole_acc_y: parseFloat(data["insole"]["left"]["y"]),
          left_insole_acc_z: parseFloat(data["insole"]["left"]["z"]),
          left_insole_pressure_a: parseFloat(data["insole"]["left"]["a"]),
          left_insole_pressure_b: parseFloat(data["insole"]["left"]["b"]),
          left_insole_pressure_c: parseFloat(data["insole"]["left"]["c"]),
          left_insole_pressure_d: parseFloat(data["insole"]["left"]["d"]),
          right_insole_acc_x: parseFloat(data["insole"]["right"]["x"]),
          right_insole_acc_y: parseFloat(data["insole"]["right"]["y"]),
          right_insole_acc_z: parseFloat(data["insole"]["right"]["z"]),
          right_insole_pressure_a: parseFloat(data["insole"]["right"]["a"]),
          right_insole_pressure_b: parseFloat(data["insole"]["right"]["b"]),
          right_insole_pressure_c: parseFloat(data["insole"]["right"]["c"]),
          right_insole_pressure_d: parseFloat(data["insole"]["right"]["d"]),
          band_acc_x: parseFloat(data["band"]["x"]),
          band_acc_y: parseFloat(data["band"]["y"]),
          band_acc_z: parseFloat(data["band"]["z"])
        }
      Repo.insert(record_detail)
    end)

    {:noreply, nil}
  end

  defp parseFloat(value) do
    {float_val, _} = Float.parse(value)
    float_val
  end
end
