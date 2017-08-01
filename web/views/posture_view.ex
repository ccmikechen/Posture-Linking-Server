defmodule Poselink.PostureView do
  use Poselink.Web, :view

  def render("index.json", %{postures: postures}) do
    %{data: render_many(postures, Poselink.PostureView, "posture.json")}
  end

  def render("show.json", %{posture: posture}) do
    %{data: render_one(posture, Poselink.PostureView, "posture.json")}
  end

  def render("posture.json", %{posture: posture}) do
    %{
      id: posture.id,
      name: posture.name,
      classification: posture.classification.name,
      type: posture.type
    }
  end

  def render("records.json", %{records: records}) do
    %{data: render_many(records, Poselink.PostureView, "record.json")}
  end

  def render("record.json", %{record: record}) do
    %{
      id: record.meta.id,
      width: record.meta.width,
      height: record.meta.height,
      insole_size: record.meta.insole_size,
      posture: %{
        id: record.meta.posture.id,
        name: record.meta.posture.name
      },
      datetime: record.meta.updated_at,
      status: record.meta.status,
      data: render_many(record.data, Poselink.PostureView, "record_detail.json")
    }
  end

  def render("record_detail.json", %{data: data}) do
    %{
      sequence_number: data.sequence_number,
      left_insole: %{
        acc: %{
          x: data.left_insole_acc_x,
          y: data.left_insole_acc_y,
          z: data.left_insole_acc_z
        },
        pressure: %{
          a: data.left_insole_pressure_a,
          b: data.left_insole_pressure_b,
          c: data.left_insole_pressure_c,
          d: data.left_insole_pressure_d
        }
      },
      right_insole: %{
        acc: %{
          x: data.right_insole_acc_x,
          y: data.right_insole_acc_y,
          z: data.right_insole_acc_z
        },
        pressure: %{
          a: data.right_insole_pressure_a,
          b: data.right_insole_pressure_b,
          c: data.right_insole_pressure_c,
          d: data.right_insole_pressure_d
        }
      },
      band: %{
        acc: %{
          x: data.band_acc_x,
          y: data.band_acc_y,
          z: data.band_acc_z
        },
        gyro: %{
          x: data.band_gyro_x,
          y: data.band_gyro_y,
          z: data.band_gyro_z
        }
      }
    }
  end

  def render("dataset.json", %{dataset: {data, type}}) do
    %{
      data: data,
      type: type
    }
  end

  def render("build.json", %{graph_path: graph_path}) do
    %{
      path: graph_path
    }
  end
end
