log.script("dish.lua")

Dish = {
	act_interval_time = 10,
	name_idx_max = 188, -- 7
}
Dish.cls = "dish"
Dish.fac = Dish.cls.."Fac"
Dish.Fac = Obj.fac..Dish.cls
Cls.add(Dish)

-- ar.idx_2_ha(Dish.gold, "dish")

function Dish.cre(pos, prm)
	local Cls = Dish
	local id = Sp.cre(Cls, pos, prm)
	return id
end

-- script method

function Dish.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Holdable)
	extend.init(_s, Food)
	extend._(_s, Dish)
end

function Dish.upd(_s, dt)

	_s:act_interval(dt)

	_s:upd_pos_static(dt)
end

function Dish.act_interval(_s, dt)

	if not _s:is_loop__act_interval__(dt) then return end

	-- death
	if _s:per_trnsf(1 / 20 * 100, Humus) then return end
end
