# Copyright (C) 2020 by the Georgia Tech Research Institute (GTRI)
# This software may be modified and distributed under the terms of
# the BSD 3-Clause license. See the LICENSE file for details.

defmodule LowendinsightGet.Application do
  use Application

  alias LowendinsightGet.Endpoint

  def start(_type, _args),
    do: Supervisor.start_link(children(), opts())

  defp children do
    [
      Endpoint
    ]
  end

  defp opts do
    [
      strategy: :one_for_one,
      name: LowendinsightGet.Supervisor
    ]
  end
end
