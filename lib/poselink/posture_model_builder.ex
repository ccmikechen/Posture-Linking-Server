defmodule Poselink.PostureModelBuilder do
  import Ecto.Query

  alias Export.Python
  alias Poselink.Repo
  alias Poselink.Posture

  @rows 17
  @cols 16
  @model_path "./models/"
  @python_path "./python/"

  def build({data, type}) do
    [classes] = from(p in Posture, select: count(p.id)) |> Repo.all()

    {:ok, pid} = Python.start_link(python_path: @python_path)
    graph_path = Python.call(pid, "poselink", "build_posture_model", [
          data, type, {@rows, @cols}, classes + 1, @model_path
        ])

    graph_path
  end
end
