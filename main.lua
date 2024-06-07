function love.load()
  game = {
    time = 0,
    scale = 6,
    player = {
      sprite = 1,
      x = 0, y = 0,
      px = 0, py = 0,
      flip = false
    },
    map = {
      canvas = nil
    }
  }

  love.graphics.setDefaultFilter('nearest')
  require('src/lib')

  map()
end

function love.keypressed(_, scancode)
  local x, y = 0, 0
  if scancode == 'w' or scancode == 'up' then y = y - 1 end
  if scancode == 's' or scancode == 'down' then y = y + 1 end
  if scancode == 'a' or scancode == 'left' then x = x - 1 end
  if scancode == 'd' or scancode == 'right' then x = x + 1 end

  game.player.flip = x == 0 and game.player.flip or x < 0
  game.player.x = game.player.x + x
  game.player.y = game.player.y + y
end

function love.update(dt)
  game.time = game.time + dt

  game.player.px = game.player.px + ((game.player.x * 8 * game.scale) - game.player.px) * 0.2
  game.player.py = game.player.py + ((game.player.y * 8 * game.scale) - game.player.py) * 0.2
end

function love.draw()
  love.graphics.draw(game.map.canvas, 0, 0, 0, game.scale)

  local n = game.player.sprite + math.floor(game.time % 2)
  sprite(n, game.player.px, game.player.py, game.scale, game.player.flip)
end
