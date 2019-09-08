require "rubygems"
require "bundler/setup"
require "bindata"
require "set"

module Liero
  DEFAULT_MATERIALS = [
    0,  9,  10, 0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  1,  1,  1,

    1,  1,  1,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  32, 32,

    32, 32, 32, 32, 32, 32, 32, 0,  0,  0,  0,  0,  0,  0,  0,  0,

    0,  0,  0,  0,  0,  0,  0,  1,  1,  1,  1,  4,  4,  4,  0,  0,

    0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  9,  9,  9,

    0,  0,  1,  1,  1,  4,  4,  4,  1,  1,  1,  4,  4,  4,  2,  2,

    2,  2,  1,  1,  1,  1,  1,  1,  0,  0,  0,  0,  0,  0,  0,  0,

    0,  0,  0,  0,  0,  0,  0,  0,  1,  1,  1,  4,  4,  4,  0,  0,

    0,  0,  8,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,

    0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,

    24, 24, 24, 24, 8,  8,  8,  8,  0,  0,  0,  0,  0,  0,  0,  0,

    1,  1,  1,  1,  1,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,

    0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,

    0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,

    0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,

    0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
  ].freeze

  DEFAULT_PALETTE = [
    0, 0, 0, 
    108, 56, 0, 
    108, 80, 0, 
    164, 148, 128, 
    0, 144, 0, 
    60, 172, 60, 
    252, 84, 84, 
    168, 168, 168, 
    84, 84, 84, 
    84, 84, 252, 
    84, 216, 84, 
    84, 252, 252, 
    120, 64, 8, 
    128, 68, 8, 
    136, 72, 12, 
    144, 80, 16, 
    152, 84, 20, 
    160, 88, 24, 
    172, 96, 28, 
    76, 76, 76, 
    84, 84, 84, 
    92, 92, 92, 
    100, 100, 100, 
    108, 108, 108, 
    116, 116, 116, 
    124, 124, 124, 
    132, 132, 132, 
    140, 140, 140, 
    148, 148, 148, 
    156, 156, 156, 
    56, 56, 136, 
    80, 80, 192, 
    104, 104, 248, 
    144, 144, 244, 
    184, 184, 244, 
    108, 108, 108, 
    144, 144, 144, 
    180, 180, 180, 
    216, 216, 216, 
    32, 96, 32, 
    44, 132, 44, 
    60, 172, 60, 
    112, 188, 112, 
    164, 212, 164, 
    108, 108, 108, 
    144, 144, 144, 
    180, 180, 180, 
    216, 216, 216, 
    168, 168, 248, 
    208, 208, 244, 
    252, 252, 244, 
    60, 80, 0, 
    88, 112, 0, 
    116, 144, 0, 
    148, 176, 0, 
    120, 72, 52, 
    156, 120, 88, 
    196, 168, 124, 
    236, 216, 160, 
    156, 120, 88, 
    196, 168, 124, 
    236, 216, 160, 
    200, 100, 0, 
    160, 80, 0, 
    72, 72, 72, 
    108, 108, 108, 
    144, 144, 144, 
    180, 180, 180, 
    216, 216, 216, 
    252, 252, 252, 
    196, 196, 196, 
    144, 144, 144, 
    152, 60, 0, 
    180, 100, 0, 
    208, 140, 0, 
    236, 180, 0, 
    168, 84, 0, 
    216, 0, 0, 
    188, 0, 0, 
    164, 0, 0, 
    200, 0, 0, 
    172, 0, 0, 
    216, 0, 0, 
    188, 0, 0, 
    164, 0, 0, 
    216, 0, 0, 
    188, 0, 0, 
    164, 0, 0, 
    80, 80, 192, 
    104, 104, 248, 
    144, 144, 244, 
    80, 80, 192, 
    104, 104, 248, 
    144, 144, 244, 
    148, 136, 0, 
    136, 124, 0, 
    124, 112, 0, 
    116, 100, 0, 
    132, 92, 40, 
    160, 132, 72, 
    188, 176, 104, 
    216, 220, 136, 
    248, 248, 188, 
    244, 244, 252, 
    252, 0, 0, 
    248, 24, 4, 
    248, 52, 8, 
    248, 80, 16, 
    248, 108, 20, 
    248, 136, 24, 
    248, 164, 32, 
    248, 192, 36, 
    248, 220, 40, 
    244, 232, 60, 
    244, 244, 80, 
    244, 244, 112, 
    244, 244, 148, 
    240, 240, 180, 
    240, 240, 212, 
    240, 240, 248, 
    44, 132, 44, 
    60, 172, 60, 
    112, 188, 112, 
    44, 132, 44, 
    60, 172, 60, 
    112, 188, 112, 
    248, 60, 60, 
    244, 124, 124, 
    244, 188, 188, 
    104, 104, 248, 
    144, 144, 244, 
    184, 184, 244, 
    144, 144, 244, 
    60, 172, 60, 
    112, 188, 112, 
    164, 212, 164, 
    112, 188, 112, 
    148, 136, 0, 
    136, 116, 0, 
    124, 96, 0, 
    112, 76, 0, 
    100, 56, 0, 
    88, 40, 0, 
    104, 104, 136, 
    144, 144, 192, 
    188, 188, 248, 
    200, 200, 244, 
    220, 220, 244, 
    40, 112, 40, 
    44, 132, 44, 
    52, 152, 52, 
    60, 172, 60, 
    252, 200, 200, 
    244, 164, 164, 
    248, 92, 92, 
    244, 76, 76, 
    244, 60, 60, 
    244, 76, 76, 
    244, 92, 92, 
    244, 164, 164, 
    84, 40, 0, 
    88, 40, 0, 
    92, 44, 0, 
    96, 48, 0, 
    60, 28, 0, 
    64, 28, 0, 
    68, 32, 0, 
    72, 36, 0, 
    252, 252, 252, 
    220, 220, 220, 
    188, 188, 188, 
    156, 156, 156, 
    124, 124, 124, 
    156, 156, 156, 
    188, 188, 188, 
    220, 220, 220, 
    108, 76, 44, 
    124, 84, 48, 
    140, 96, 56, 
    156, 108, 64, 
    172, 120, 72, 
    0, 0, 0, 
    40, 36, 8, 
    80, 76, 20, 
    120, 116, 28, 
    160, 152, 40, 
    200, 192, 48, 
    244, 232, 60, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    0, 0, 0, 
    252, 0, 0, 
    252, 36, 0, 
    252, 72, 0, 
    252, 108, 0, 
    252, 144, 0, 
    252, 180, 0, 
    252, 216, 0, 
    252, 252, 0, 
    168, 240, 0, 
    84, 232, 0, 
    0, 224, 0, 
    252, 0, 0, 
    232, 4, 20, 
    216, 12, 44, 
    196, 20, 68, 
    180, 24, 88, 
    160, 32, 112, 
    144, 40, 136, 
    124, 44, 156, 
    108, 52, 180, 
    88, 60, 204, 
    72, 68, 228
  ].freeze

  class Color < BinData::Record
    uint8 :r
    uint8 :g
    uint8 :b

    def black?
      r == 0 && g == 0 && b == 0
    end

    def hash
      (r << 16) | (g << 8) | b
    end

    alias eql? ==

    def next
      new(r: r.next, g: g.next, b: b.next)
    end

    def next!
      self.r = r.next
      self.g = g.next
      self.b = b.next
    end
  end

  class Material < BinData::Record
    TYPES = [:dirt_1, :dirt_2, :dirt, :rock, :background, :see_shadow, :worm, :other].freeze

    uint8 :m

    def dirt_1?
      1 & m > 0
    end

    def dirt_2?
      (1 << 1) & m > 0
    end

    def dirt?
      dirt_1? || dirt_2?
    end

    def rock?
      (1 << 2) & m > 0
    end

    def background?
      (1 << 3) == m
    end

    def see_shadow?
      (1 << 4) | (1 << 3) == m
    end

    def worm?
      (1 << 5) & m > 0
    end

    def other?
      !dirt? && !rock? && !background? && !see_shadow? && !worm?
    end

    def filter(type)
      raise unless TYPES.include?(type.to_sym)
      send("#{type}?")
    end
  end

  class Materials < BinData::Array
    default_parameters initial_length: 256, type: Material

    def self.load_default
      read(Liero::DEFAULT_MATERIALS.pack("C*"))
    end
  end

  class Palette < BinData::Array
    default_parameters initial_length: 256, type: Color

    def self.load_default
      read(Liero::DEFAULT_PALETTE.pack("C*"))
    end

    def make_unique!
      siblings = self.siblings

      siblings.each do |color, set|
        a = set.to_a
        a.pop
        alt_color = color.next
        a.each do |i|
          alt_color.next! while siblings.key?(alt_color)
          self[i] = alt_color
          alt_color.next!
        end
      end
    end

    def siblings
      ss = {}

      each_with_index do |color, i1|
        next if color.black?
        each_with_index do |other_color, i2|
          if i1 != i2 && color == other_color
            (ss[color] ||= Set.new) << i1 << i2
          end
        end
      end

      ss
    end

    def dup
      self.class.new(self)
    end
  end

  class GimpPaletteWriter
    HEADER = "GIMP Palette".freeze

    def initialize(palette, name)
      @palette = palette
      @name = name
    end

    def dump(path)
      File.open(path, "w") { |f| write(f) }
    end

    def write(io)
      io.puts HEADER
      io.puts @name
      io.print "#"
      @palette.each do |color|
        io.puts
        io.printf("%3d %3d %3d", color.r, color.g, color.b)
      end
    end
  end

  class PaletteWithMaterials < Struct.new(:palette, :materials)
    DEFAULT_FILTER_OUT_COLOR = Color.new(r: 255, g: 0, b: 255).freeze

    def self.load_defaults
      new(Palette.load_default, Materials.load_default)
    end

    def filter_palette_by_material(type, filter_out_color = DEFAULT_FILTER_OUT_COLOR)
      filtered = palette.dup
      filtered.each_with_index do |_, i|
        filtered[i] = filter_out_color unless materials[i].filter(type)
      end
      filtered
    end

    def reduce_palette_by_material(type)
      Palette.new(palette.select.with_index { |c, i| materials[i].filter(type) })
    end
  end
end
