defmodule Utils do
  def read_input(path) do
    {:ok, contents} = File.read(path)

    contents
  end
end
