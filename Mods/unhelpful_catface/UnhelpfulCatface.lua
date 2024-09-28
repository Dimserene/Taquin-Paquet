--- STEAMODDED HEADER
--- MOD_NAME: Unhelpful Cat Face
--- MOD_ID: UnhelpfulCat
--- MOD_AUTHOR: [TheFinickyCynic]
--- MOD_DESCRIPTION: Replaces the very important Chip, Mult, Hands, Discards, and Money HUD readouts with a much more helpful :3 face

----------------------------------
------------ MOD CODE ------------

local create_UIBox_HUDRef = create_UIBox_HUD
local scale = 0.4
local spacing = 0.13

function create_UIBox_HUD()

	
    local full_HUD_contents = create_UIBox_HUDRef()
	
	local contents = {}
	
	--Dividing up the output of the old create_UIBox_HUD function to match
	--how it reads in UI_Definitions.lua
	
    contents.round = full_HUD_contents.nodes[1].nodes[1].nodes[5].nodes[2]
	
	contents.buttons = full_HUD_contents.nodes[1].nodes[1].nodes[5].nodes[1]
	
	contents.dollars_chips = full_HUD_contents.nodes[1].nodes[1].nodes[3]
	
	contents.hand = full_HUD_contents.nodes[1].nodes[1].nodes[4]
	
	--Actual modification of the values that will be left as a static ':3'
	
	--Held Money
	contents.round.nodes[3].nodes[1].nodes[1].nodes[1].nodes[1].config={object = DynaText({string = ':3', maxw = 1.35, colours = {G.C.MONEY}, font = G.LANGUAGES['en-us'].font, shadow = true,spacing = 2, bump = true, scale = 2.2*scale}), id = 'dollar_text_UI'}
	--Number of Hands
	contents.round.nodes[1].nodes[1].nodes[2].nodes[1].config={object = DynaText({string = ':3', font = G.LANGUAGES['en-us'].font, colours = {G.C.BLUE},shadow = true, rotate = true, scale = 2*scale}),id = 'hand_UI_count'}
	--Number of Discards
	contents.round.nodes[1].nodes[3].nodes[2].nodes[1].nodes[1].config={object = DynaText({string = ':3', font = G.LANGUAGES['en-us'].font, colours = {G.C.RED},shadow = true, rotate = true, scale = 2*scale}),id = 'discard_UI_count'}
	
	
	return(full_HUD_contents)
	
end

--takeovers of the UI set functions to handle dynamic faces

G.FUNCS.hand_mult_UI_set = function(e)
	local new_mult_text = ':3'
	
	if G.ARGS.score_intensity.earned_score >= G.ARGS.score_intensity.required_score and G.ARGS.score_intensity.required_score > 0 then
		new_mult_text = '>:3'
	end
	
	if new_mult_text ~= G.GAME.current_round.current_hand.mult_text then 
		G.GAME.current_round.current_hand.mult_text = new_mult_text
		e.config.object.scale = scale_number(G.GAME.current_round.current_hand.mult, 0.9, 1000)
		e.config.object:update_text()
		if not G.TAROT_INTERRUPT_PULSE then G.FUNCS.text_super_juice(e, math.max(0,math.floor(math.log10(type(G.GAME.current_round.current_hand.mult) == 'number' and G.GAME.current_round.current_hand.mult or 1)))) end
	end
end

G.FUNCS.hand_chip_UI_set = function(e)
	local new_chip_text = ':3'
	
	if G.ARGS.score_intensity.earned_score >= G.ARGS.score_intensity.required_score and G.ARGS.score_intensity.required_score > 0 then
		new_chip_text = '>:3'
	end
	
	if new_chip_text ~= G.GAME.current_round.current_hand.chip_text then 
		G.GAME.current_round.current_hand.chip_text = new_chip_text
		e.config.object.scale = scale_number(G.GAME.current_round.current_hand.chips, 0.9, 1000)
		e.config.object:update_text()
		if not G.TAROT_INTERRUPT_PULSE then G.FUNCS.text_super_juice(e, math.max(0,math.floor(math.log10(type(G.GAME.current_round.current_hand.chips) == 'number' and G.GAME.current_round.current_hand.chips or 1)))) end
	end
end
----------------------------------
---------- MOD CODE END ----------
