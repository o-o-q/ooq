log.script("bush.lua")

Bush = {
	act_interval_time = 15,
	name_idx_max = 100,
	foot_dst_i = 40,
	z = 0.04,
}
Bush.cls = "bush"
Bush.Fac = Obj.fac..Bush.cls
Cls.add(Bush)

-- static

function Bush.cre(pos)
	local Cls = Bush
	local id = Sp.cre(Cls, pos)
	return id
end

-- script method

function Bush.init(_s)

	extend.init(_s, Sp)
	extend._(_s, Bush)
end

function Bush.upd(_s, dt)

	_s:act_interval(dt)

	_s:upd_pos_static(dt)
end

function Bush.act_interval(_s, dt)

	if not _s:is_loop__act_interval__(dt) then return end

	if _s:per_trnsf(1 / 10 * 100, Humus) then return end

	dice100.throw()
	if     dice100.chk(15) then
		-- empty -- _s:trnsf(Tree)
	end
end

function Bush.final(_s)
	Sp.final(_s)
end
