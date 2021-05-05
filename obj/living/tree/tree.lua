log.scrpt("tree.lua")

Tree = {
	act_intrvl_time = 5,
	name_idx_max = 100,

	z = 0.05,
}
Tree.cls = "tree"
Tree.fac = Obj.fac..Tree.cls
Cls.add(Tree)

-- static

function Tree.cre(p_pos, prm, p_scl)
	local t_Cls = Tree
	local t_id = Sp.cre(t_Cls, p_pos, prm, p_scl)
	return t_id
end

-- script method

function Tree.init(_s)

	extend._(_s, Sp)
	extend._(_s, Tree)
end

function Tree.__init(_s, prm)
	
	Tree.bear__init(_s)

	Sp.__init(_s, prm)

	-- scale
	local size  = 1.5
	local t_url = url._(_s._id, "sprite")
	local scale = go.get(t_url, "scale")
	go.set(t_url, "scale", scale * size)

	-- log._("tree init", _s._nameHa, _s._bear_clsHa, _s._bear_nameHa)
	_s._bear = {}
end

function Tree.upd(_s, dt)
	
	_s:act_intrvl(dt)
	
	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Tree.on_msg(_s, msg_id, prm, sndr)
	
	Sp.on_msg(_s, msg_id, prm, sndr)
	
	if     ha.eq(msg_id, "trnsf_wood") then
		_s:trnsf_wood()
		
	elseif ha.eq(msg_id, "bear__x") then
		_s:bear__x(prm.bear_id)
	end
end

function Tree.final(_s)
	
	Sp.final(_s)
	
	for idx, bear_id in pairs(_s._bear) do
		pst.scrpt(bear_id, "bear__x")
	end
end

-- method

function Tree.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	-- log._("Tree.act_intrvl", _s._bear_clsHa, _s._bear_nameHa)

	dice100.throw()
	if     dice100.chk(1) then
		_s:trnsf(Wood)

	elseif dice100.chk(1) then
		Leaf.cre()

	elseif dice100.chk(5) then
		_s:bear()
	end
end

function Tree.bear(_s)
	
	if #_s._bear >= 1 then return end
	
	if ha.is_emp(_s._bear_clsHa) then _s:bear__init() end

	local bear_Cls = Cls._(_s._bear_clsHa)
	
	if ha.is_emp(_s._bear_nameHa) then
		_s._bear_nameHa = ha._(bear_Cls.cls..rnd.int_pad(bear_Cls.name_idx_max))
	end
	
	local t_pos = _s:pos_w() + n.vec(0, Map.sqh)
	-- log._("bear fruit cre")
	local t_id = bear_Cls.cre(t_pos, {_nameHa = _s._bear_nameHa}, 0.2)
	pst.scrpt(t_id, "bear__o", {tree_id = _s._id})
	ar.add(_s._bear, t_id)
end

function Tree.bear__x(_s, bear_id)
	ar.del_by_val(_s._bear, bear_id)
end

function Tree.trnsf_wood(_s, num)

	num = num or 3
	local t_pos, x
	for i = 1, num do
		x = u.x_by_all_w(i, num, Map.sq)
		t_pos = _s:pos() + n.vec(x, Map.sqh)
		Wood.cre(t_pos)
	end
	Se.pst_ply("tree_break")
	
	_s:del()
end

function Tree.bear__init(_s)

	ha.is_emp__(_s._bear_clsHa , "fruit"   )
	ha.is_emp__(_s._bear_nameHa, "fruit007")
end

