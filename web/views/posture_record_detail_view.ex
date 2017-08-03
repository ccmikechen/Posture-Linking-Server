defmodule Poselink.PostureRecordDetailView do
  use Poselink.Web, :view

  def render("index.json", %{posture_record_details: details}) do
    %{data: render_many(details, Poselink.PostureRecordDetailView, "record_detail.json")}
  end

  def render("record_detail.json", %{posture_record_detail: data}) do
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
end
