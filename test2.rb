require 'gosu'

class PlayerGame < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Player Game"

    @player = Player.new
    @projectiles = []
    @asteroid = []
  end

  def update
    @player.update
    @asteroid.each(&:update)
    @projectiles.each(&:update)
    @spawn = rand(1..50)
    if @spawn == 9
      @asteroid << Asteroid.new(rand(640), 0)
    end
    
  end

  #projectiles[1].projectile_x

  def draw
    @player.draw
    @asteroid.each(&:draw)
    @projectiles.each(&:draw)
  end
  
  def button_down(id)
    close if id == Gosu::KbEscape
    if id == Gosu::KbSpace
      angle = @player.angle
      @projectiles << Projectile.new(@player.x + 10, @player.y + 10, angle)
    end
  end
end

class Projectile
  def initialize(x, y, angle)
    @image = Gosu::Image.new("projectile.png")
    @x = x
    @y = y
    @angle = angle
    @speed = 8
    $projectile_x = 0
    $projectile_y = 0
  end


  def update
    @x += Gosu.offset_x(@angle, @speed)
    @y += Gosu.offset_y(@angle, @speed)
    $projectile_x = @x
    $projectile_y = @y
  end

  def draw
    @image.draw(@x, @y, 1)
  end
end


class Player
  attr_reader :x, :y, :angle
  def initialize
    @image = Gosu::Image.new("player.png")
    @x = 320
    @y = 440
    @speed = 4
    @angle = 45
  end

  def update
    if Gosu.button_down?(Gosu::KbUp)
      @x += Gosu.offset_x(@angle, @speed)
      @y += Gosu.offset_y(@angle, @speed)
    end

    if Gosu.button_down?(Gosu::KbRight)
      @angle += 5
    end

    if Gosu.button_down?(Gosu::KbLeft)
      @angle -= 5
    end

    if @x > 640
      @x = 0
    elsif @y > 480
      @y = 0
    elsif @x < 0
      @x = 640
    elsif @y < 0
      @y = 480
    end

  end

  def draw
    @image.draw(@x, @y, 1)
  end
end

class Asteroid
  attr_reader :x, :y, :angle
  def initialize(x, y)
    @image = Gosu::Image.new("asteroid.png")
    @x = x
    @y = y
    @angle = rand(90..270)
    @speed = 2
    $asteroid_x = 0
    $asteroid_y = 0
  end

  def update
    @x += Gosu.offset_x(@angle, @speed)
    @y += Gosu.offset_y(@angle, @speed)
    if @x > 640
      @x = 0
    elsif @y > 480
      @y = 0
    end
  end

  def draw
    @image.draw(@x, @y)
  end
end


PlayerGame.new.show


