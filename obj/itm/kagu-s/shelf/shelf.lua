log.scrpt("shelf.lua")

Shelf = {

	act_intrvl_time = 10,
	name_idx_max = 1,
	z = 0.1,

	weight = 2,
}
Shelf.cls = "shelf"
Shelf.fac = Obj.fac..Shelf.cls
Cls.add(Shelf)

-- static

function Shelf.cre(p_pos, prm)
	local Cls = Shelf
	local t_id = Sp.cre(Cls, p_pos, prm)
	return t_id
end

-- script method

function Shelf.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend._(_s, Shelf)
end

function Shelf.upd(_s, dt)

	_s:act_intrvl(dt)
	
	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Shelf.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	-- log._("shelf z", _s:z())

end

function Shelf.on_msg(_s, msg_id, prm, sndr)
	
	Sp.on_msg(_s, msg_id, prm, sndr)
	Hldabl.on_msg(_s, msg_id, prm, sndr)
	
	if ha.eq(msg_id, "opn") then
		_s:opn()
	end
end

function Shelf.final(_s)
	Sp.final(_s)
	Hldabl.final(_s)
end

-- method

function Shelf.opn(_s)
	fac.cre("#fac_shelf_gui")
end
