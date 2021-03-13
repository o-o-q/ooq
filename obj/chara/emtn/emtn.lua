log.scrpt("emtn.lua")

Emtn = {
	act_intrvl_time = 3,
	name_idx_max = 1, -- 28
}
Emtn.cls = "emtn"
Emtn.fac = Obj.fac..Emtn.cls
Cls.add(Emtn)

-- static

function Emtn.cre(pos, emtnnum)
	emtnnum = emtnnum or 1
	local id = Sp.cre(Emtn, pos, {emtnnum = emtnnum})
	return id
end

-- script method

function Emtn.init(_s)

	extend.init(_s, Sp)
	extend._(_s, Emtn)
	
	_s._speed = 7

	local anim = "emtn"..int.pad(_s._emtnnum, 3)
	pst._("#sprite", "play_animation", {id = ha._(anim)})

	if _s._emtnnum == 1 then
		Se.pst_ply("heart")
	end
end

function Emtn.upd(_s, dt)
	
	_s:act_intrvl(dt)
	
	local vec = n.vec(0, 1) * _s._speed * dt
	_s:pos__add(vec)
end

function Emtn.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	_s:del()
end
