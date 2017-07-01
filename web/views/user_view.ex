defmodule Poselink.UserView do
  use Poselink.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, Poselink.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Poselink.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      email: user.email,
      password_hash: user.password_hash,
      nickname: user.nickname}
  end
end
