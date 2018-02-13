defmodule Memory.Game do
  def new do
    beginGame = ["A", "B", "C","D","E","F","G","H","A", "B","C","D","E","F","G","H"];
    %{
      squares: Enum.shuffle(beginGame),
      currentSquare: List.duplicate(nil, 16),
      prevSquare: %{id: nil, value: nil},
      flipped: true,
      count: 0,
      prevSquareid: nil,
      locked: false,
      matches: 0,
    }
  end

  def client_view(game) do

  squares = game.squares
  #IO.inspect squares
  currentSquare =  game.currentSquare
  #IO.inspect currentSquare
  #prevSquare = game.prevSquare
  locked = game.locked

  %{
    currentSquare: currentSquare,
    flipped: game.flipped,
    count: game.count,
    locked: locked,
    prevSquareid: game.prevSquareid,
    matches: game.matches
  }
  end

  def checkMatch(game, id, currentSquare, flipped, count, locked, matches) do
    sqvalue = Enum.at(game.squares, id)
    #IO.inspect sqvalue
    IO.inspect "flipped"
    IO.inspect flipped
    if !locked do
        local_flip = flipped
        #IO.inspect trial_flip
        #IO.inspect game
        #prevSquareID = game.prevSquare.id #get tuple id
        #IO.inspect prevSquareid
        prevSquareval = game.prevSquare.value #get tuple value
        #empty square clicked
        if (Enum.at(currentSquare, id) == nil) do
          count = count + 1
          #currentSquare.id = sqvalue
          currentSquare = List.replace_at(currentSquare, id, sqvalue)
          local_flip = !flipped

          IO.inspect local_flip
          #second square if this true
          if local_flip do
            if prevSquareval == sqvalue do
              IO.inspect "elements match prevSquareval"
              IO.inspect prevSquareval
              matches = matches + 1
              locked = true
              prevSquareid = game.prevSquare.id
              #value = Enum.at(game.squares, id)
              game = put_in(game, [:prevSquare, :id], id)
              game = put_in(game, [:prevSquare, :value], sqvalue)
              prevSquare = game.prevSquare

              %{
                squares: game.squares,
                currentSquare: currentSquare,
                prevSquare: prevSquare,
                flipped: local_flip,
                count: count,
                prevSquareid: prevSquareid,
                locked: locked,
                matches: matches
              }
            #elements dont match
            else
              IO.inspect "elements dont match"
              locked = true
              prevSquareid = game.prevSquare.id
              #value = Enum.at(game.squares, id)
              game = put_in(game, [:prevSquare, :id], id)
              game = put_in(game, [:prevSquare, :value], sqvalue)
              prevSquare = game.prevSquare

              %{
                squares: game.squares,
                currentSquare: currentSquare,
                prevSquare: prevSquare,
                flipped: local_flip,
                count: count,
                prevSquareid: prevSquareid,
                locked: locked,
                matches: matches
              }
            end
            #first square clicked
          else
            #currentSquare.id = sqvalue
            IO.inspect "here?"
            currentSquare = List.replace_at(currentSquare, id, sqvalue)
            prevSquareid = game.prevSquare.id
            #value = Enum.at(game.squares, id)
            game = put_in(game, [:prevSquare, :id], id)
            game = put_in(game, [:prevSquare, :value], sqvalue)
            prevSquare = game.prevSquare

            %{
              squares: game.squares,
              currentSquare: currentSquare,
              prevSquare: prevSquare,
              flipped: local_flip,
              count: count,
              prevSquareid: prevSquareid,
              locked: locked,
              matches: matches
            }
        end
    end
  end
end

def handleto(game, currentSquare, prevSquareid) do
  value = game.prevSquare.value
  if Enum.at(game.squares,prevSquareid) == value do
    val = "$"
    local = List.replace_at(currentSquare, game.prevSquare.id, val)
    |> List.replace_at(prevSquareid, val)

  else

    local = List.replace_at(currentSquare, game.prevSquare.id, nil)
    |> List.replace_at(prevSquareid, nil)
  end
  %{
    squares: game.squares,
    currentSquare: local,
    prevSquare: game.prevSquare,
    flipped: game.flipped,
    count: game.count,
    prevSquareid: game.prevSquareid,
    locked: false,
    matches: game.matches,
  }
  end


end
