log.scrpt("shtngstr.lua")

Shtngstr = {
	act_intrvl_time = 10,
	name_idx_max    =  1,
}
Shtngstr.cls = "shtngstr"
Shtngstr.fac = Obj.fac..Shtngstr.cls
Cls.add(Shtngstr)

-- static

function Shtngstr.cre(p_pos, prm)
	local t_Cls = Shtngstr
	prm = prm or {}
	if not prm._animHa then prm._animHa = ha._("stand") end
	-- if not prm._anim   then prm._anim   =      "stand"  end
	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- script method

function Shtngstr.init(_s)

	extend._(_s, Sp)
	extend._(_s, Hldabl)
	extend._(_s, Shtngstr)
end

function Shtngstr.__init(_s, prm)
	
	Sp    .__init(_s, prm)
	Hldabl.__init(_s)
end

function Shtngstr.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Shtngstr.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	-- death
	
end

function Shtngstr.on_msg(_s, msg_id, prm, sndr)
	Sp.on_msg(_s, msg_id, prm, sndr)
	Hldabl.on_msg(_s, msg_id, prm, sndr)
end

function Shtngstr.final(_s)
	Sp.final(_s)
	Hldabl.final(_s)
end

