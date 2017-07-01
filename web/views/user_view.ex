defmodule Poselink.UserView do
  use Poselink.Web, :view

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      email: user.email,
      nickname: user.nickname}
  end
end
