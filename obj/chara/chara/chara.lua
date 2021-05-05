log.scrpt("chara.lua")

Chara = {
	
	act_intrvl_time = 8,
	speed           = 2, -- 50,
	
	chara = {
		"sanae",
		"marin", "katia", "matilda",
		"sayaka", "yuki", "kurumi",
		"lily", "sofia",
		"shiki", "kageri",
	},
	flyabl = {
		"katia", "lily", "sofia",
	},
	presentabl = {"flower","dish","fruit","dairy","egg","veget",}, -- cls
}
Chara.cls = "chara"
Chara.fac = Obj.fac..Chara.cls
Cls.add(Chara)
ha.add_by_ar(Chara.chara)

-- static

function Chara.cre(p_pos, p_name)
	
	if Map.chara_is_appear_all() then return end
	
	p_pos  = p_pos  or pos.pos_w()
	p_name = p_name or Chara.new_name()
	
	local prm = {}

	prm._clsHa  = ha._(Chara.cls)
	prm._nameHa = ha._(p_name)

	prm._is_flyabl = ar.in_(p_name, Chara.flyabl) -- to init
	
	local t_Cls = Chara
	local t_id = Sp.cre(t_Cls, p_pos, prm)

	Map.add_chara(p_name)
	return t_id
end

function Chara.new_name()

	local not_appear_chara = Map.not_appear_chara()
	local new_name = ar.rnd(not_appear_chara)
	return new_name
end

-- script method

function Chara.init(_s)

	extend._(_s, Sp)
	extend._(_s, Livingmove)
	extend._(_s, Chara)
end

function Chara.__init(_s, prm)
	
	_s._name   = ha.de(_s._nameHa)
	_s._animHa = _s._name.."-walk"

	Sp        .__init(_s, prm)
	Livingmove.__init(_s)

	_s:say()
	_s:act_intrvl_time__()
end

function Chara.upd(_s, dt)
	
	_s:act_intrvl(dt)
	
	_s:upd_pos_movabl(dt)

	_s:upd_final()
end

function Chara.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	-- log._("chara act_intrvl is_loop", _s:name(), _s._act_intrvl_time)
	
	dice100.throw()
	if     dice100.chk(1) then
		Seed.cre()
	end

	_s:moving_prp__rnd()
	
	-- say
	if rnd.by_f(2/5) then _s:say() end

	_s:act_intrvl_time__()
end

function Chara.on_msg(_s, msg_id, prm, sndr)

	Sp.on_msg(_s, msg_id, prm, sndr)
	
	if ha.eq(msg_id, "present") then
		
		local t_id = prm.id
		local t_clsHa  = id.clsHa(t_id)
		if not ar.inHa(t_clsHa, Chara.presentabl) then return end
		
		id.del(t_id)
		Emtn.cre(_s:pos() + n.vec(0, Map.sqh * 3 / 2))
		_s:kzn__pls()
	end
end

function Chara.kzn__pls(_s, point)

	point = point or Mstr.kzn.point

	if not Ply_data._kzn[_s:name()] then
		Ply_data._kzn[_s:name()] = 0
	end

	Ply_data._kzn[_s:name()] = Ply_data._kzn[_s:name()] + point
end

-- method

function Chara.anim__(_s, p_anim)

	local t_anim = _s._name.."-"..p_anim
	Sp.anim__(_s, t_anim)
end

function Chara.act_intrvl__(_s, dt)

	local is_loop
	_s._act_intrvl, is_loop = num.pls_loop(_s._act_intrvl, dt, _s._act_intrvl_time)
	return is_loop
end

function Chara.act_intrvl_time__(_s)

	_s._act_intrvl_time = _s:Cls().act_intrvl_time + rnd.int(0, 3)
end

function Chara.say(_s, str)
	
	local idx, len
	if not str then
		idx = rnd.int(1, #Serifu._)
		-- log._("say", idx)
		str = Serifu._[idx].txt
		len = Serifu._[idx].len
	end
	
	local t_id = Fuki.cre(nil, {parent_id = _s._id})
	pst.scrpt(t_id, "s", {str = str, len = len})
end

