SMODS.Atlas {
    key = "rick",
    path = "rickroll.png",
    px = 71,
    py = 95
  }

SMODS.Joker{
  key = "rickrolljoker",
  loc_txt = {
    name = "Richard Rollsworth",
    text = {
      "Gives {X:mult,C:white}X#1#{} Mult"
    }
  },
  config = { extra = { x_mult = 5 } },
  rarity = 3,
  blueprint_compat = true,
  atlas = 'rick',
  pos = { x = 0, y = 0 },
  cost = 10,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.x_mult } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        Xmult_mod = card.ability.extra.x_mult,
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
      }
    end
      if context.setting_blind and not context.blueprint and not context.retrigger_joker then
          G.FUNCS.overlay_menu{
              definition = create_UIBox_custom_video1(),
              config = {no_esc = true}
          }
      end
  end
}

function create_UIBox_custom_video1()
  local file_path = SMODS.Mods["Rickroll"].path.."/resources/rickroll.ogv"
  local file = NFS.read(file_path)
  love.filesystem.write("temp.ogv", file)
  local video_file = love.graphics.newVideo('temp.ogv')
  local vid_sprite = Sprite(0,0,11*16/9,11,G.ASSET_ATLAS["ui_"..(G.SETTINGS.colourblind_option and 2 or 1)], {x=0, y=0})
  video_file:getSource():setVolume(G.SETTINGS.SOUND.volume*G.SETTINGS.SOUND.game_sounds_volume/(100*100))
  vid_sprite.video = video_file
  video_file:play()

  local t = create_UIBox_generic_options({ back_delay = 5, back_label = localize('b_skip'), colour = G.C.BLACK, padding = 0, contents = {
    {n=G.UIT.O, config={object = vid_sprite}},
  }})
  return t
end