log.scrpt("inp_plyr.lua")

Inp.plyr = {

	msh_time_lmt = 0.5, -- msh lmt ( time )
	lng_fil_num  = 0.5, -- lng press ( time )
}
Inp.plyr.keys = {}
ar.add_ar(Inp.plyr.keys, Inp.keys_arw)
ar.add_ar(Inp.plyr.keys, Inp.keys_btn)
ha.add_by_ar(Inp.plyr.keys)

-- script method

-- init

function Inp.plyr.init_plyr(_s)
	
	_s._plyr = {}

	_s._plyr._msh = {}
	for idx, key in pairs(Inp.plyr.keys) do
		_s._plyr._msh[key] = {
			time = 0,
			cnt  = 0,
		}
	end

	_s._plyr._lng_fil = {}  -- keep time

	_s._plyr._ltst_keep = nil

	_s._plyr._key     = nil
	_s._plyr._keyact  = nil
end

-- upd

function Inp.plyr.upd_plyr(_s, dt)

	_s:upd_plyr_msh_time__dec(dt)
	_s:upd_plyr_lng__inc(dt)
end

function Inp.plyr.upd_plyr_msh_time__dec(_s, dt)

	for key, tbl in pairs(_s._plyr._msh) do

		if _s._plyr._msh[key].time > 0 then

			_s._plyr._msh[key].time = _s._plyr._msh[key].time - dt
			if _s._plyr._msh[key].time <= 0 then
				_s._plyr._msh[key].cnt = 0
			end
		end
	end
end

function Inp.plyr.upd_plyr_lng__inc(_s, dt)

	if not _s._plyr._key then return end
	
	-- lng_fil
	for key, time in pairs(_s._plyr._lng_fil) do
		_s._plyr._lng_fil[key] = _s._plyr._lng_fil[key] + dt
	end
end

-- on_inp

function Inp.plyr.on_inp_plyr(_s, keyHa, keyact)
	-- log._("Inp on_inp_plyr")
	local key = ha.de(keyHa)

	_s:on_inp_plyr__(key, keyact)

	_s:on_inp_plyr_pst()

	_s:on_inp_plyr_msh__()

	_s:on_inp_fairy_pst()

	_s:on_inp_plyr_ltst_keep__()
end

function Inp.plyr.on_inp_plyr__(_s, key, keyact)
	-- log._("inp.plyr on_inp_plyr__", key)

	_s._plyr._key    = key
	_s._plyr._keyact = keyact

	-- lng_fil
	if     keyact.pressed  then
		_s._plyr._lng_fil[key] = 0
	elseif keyact.released then
		_s._plyr._lng_fil[key] = nil
	end
end

function Inp.plyr.on_inp_fairy_pst(_s)

	if not _s:is_arw() then return end

	local fairy_id = Game.fairy_id()

	local prm = {}
	prm.dir = Inp.arw_2_dir[_s._plyr._key]

	if     _s:p() then

		pst.scrpt(fairy_id, "mv__dir", prm)

	elseif _s:k() and _s:is_arw_v() and _s:is_lng() then

		pst.scrpt(fairy_id, "mv__plychara_v", prm)

	elseif _s:f() then
		
	end
end

function Inp.plyr.is_arw(_s, key)

	key = key or _s._plyr._key

	local ret = ar.in_(key, Inp.keys_arw)
	return ret
end

function Inp.plyr.is_arw_v(_s, key)

	key = key or _s._plyr._key

	local ret = ar.in_(key, Inp.keys_arw_v)
	return ret
end

function Inp.plyr.on_inp_plyr_pst(_s)
	
	local plychara_id = Game.plychara_id()

	-- mv
	if     _s:k("arw_l") then
		pst.scrpt(plychara_id, "mv", {dir = "l", dive = _s:is_lng("arw_l")})

	elseif _s:k("arw_r") then
		pst.scrpt(plychara_id, "mv", {dir = "r", dive = _s:is_lng("arw_r")})

	elseif _s:k("arw_u") then
		pst.scrpt(plychara_id, "mv", {dir = "u"})

	elseif _s:k("arw_d") then
		pst.scrpt(plychara_id, "mv", {dir = "d"})

	-- button
	elseif _s:p("z") then -- jmp
		pst.scrpt(plychara_id, "jmp")

	elseif _s:p("a") then -- itm
		pst.scrpt(plychara_id, "itm_use")

	elseif _s:p("x") then
		pst.scrpt(plychara_id, "hld__ox")

	elseif _s:p("s") then
		pst.scrpt(plychara_id, "menu_opn")

	elseif _s:p("q") then
		pst.scrpt(Sys.cmr_id(), "zoom__o")

	elseif _s:p("w") then
		pst.scrpt(Sys.cmr_id(), "zoom__i")
	end
end

function Inp.plyr.on_inp_plyr_msh__(_s)

	local key = _s._plyr._key -- alias

	local is_msh, cnt

	if _s:p(key) then

		_s._plyr._msh[key].time = Inp.plyr.msh_time_lmt

		is_msh, cnt = _s:is_msh(key)
		if is_msh then
			_s._plyr._msh[key].cnt = cnt + 1
		end
	end
end

function Inp.plyr.on_inp_plyr_ltst_keep__(_s)

	if     _s:k(key) then
		_s._plyr._ltst_keep = key
	elseif _s:f(key) then
		_s._plyr._ltst_keep = nil
	end
end

function Inp.plyr.p(_s, key) -- press

	local ret = _.f

	if key then
		if not u.eq(_s._plyr._key, key) then return ret end
	else
		key = _s._plyr._key
	end

	if _s._plyr._keyact.pressed then
		ret = _.t
	end
	return ret
end

function Inp.plyr.f(_s, key) -- free ( released )

	local ret = _.f

	if key then
		if not u.eq(_s._plyr._key, key) then return ret end
	else
		key = _s._plyr._key
	end

	if _s._plyr._keyact.released then
		ret = _.t
	end
	return ret
end

function Inp.plyr.k(_s, key) -- press keep

	local ret = _.f

	if key then
		if not u.eq(_s._plyr._key, key) then return ret end
	else
		key = _s._plyr._key
	end

	if not _s._plyr._keyact.released then
		ret = _.t
	end
	return ret
end

function Inp.plyr.is_lng(_s, key) -- lng press

	key = key or _s._plyr._key

	local ret = _.f
	
	if not _s._plyr._lng_fil[key] then
		-- nothing
	elseif _s._plyr._lng_fil[key] >= Inp.plyr.lng_fil_num then
		ret = _.t
	end
	return ret
end

function Inp.plyr.is_msh(_s, key)

	key = key or _s._plyr._key

	local ret, cnt
	if _s._plyr._msh[key].time > 0 then
		ret = _.t
		cnt = _s:msh_cnt(key)
	else
		ret = _.f
	end
	return ret, cnt
end

function Inp.plyr.msh_cnt(_s, key)
	local cnt = _s._plyr._msh[key].cnt
	return cnt
end

function Inp.plyr.is_msh_cnt_ovr(_s, key, p_cnt) -- msh success cnt

	local ret
	local is_msh, cnt = _s:is_msh(key)
	if is_msh and cnt >= p_cnt then
		ret = _.t
	else
		ret = _.f
	end
	return ret
end

function Inp.plyr.msh_fairy_pos(_s) -- use not

	local msh_pos = _s:msh_tilepos() * Map.sq
	return msh_pos
end

function Inp.plyr.msh_tilepos(_s)

	local x = _s:msh_tilepos_x()
	local y = _s:msh_tilepos_y()
	local msh_tilepos = n.vec(x, y)
	return msh_tilepos
end

function Inp.plyr.msh_tilepos_x(_s)
	
	local x = 0
	local l_cnt = _s._plyr._msh["arw_l"].cnt
	local r_cnt = _s._plyr._msh["arw_r"].cnt

	if     l_cnt > 0 then x = - l_cnt
	elseif r_cnt > 0 then x =   r_cnt
	end
	return x
end

function Inp.plyr.msh_tilepos_y(_s)

	local y = 0
	local u_cnt = _s._plyr._msh["arw_u"].cnt
	local d_cnt = _s._plyr._msh["arw_d"].cnt
	if     u_cnt > 0 then y =   u_cnt
	elseif d_cnt > 0 then y = - d_cnt
	end
	return y
end

function Inp.plyr.is_with(_s, key) -- keep

	local ret
	if _s._plyr._ltst_keep == key then
		ret = _.t
	else
		ret = _.f
	end
	return ret
end

-- key1 keep and key2 press
function Inp.plyr.is_with_p(_s, key1, key2) -- use not

	local ret
	if _s._plyr._ltst_keep == key1 and _s:p(key2) then
		ret = _.t
	else
		ret = _.f
	end
	return ret
end

-- key1 keep and key2 keep
function Inp.plyr.is_with_k(_s, key1, key2) -- use not

	local ret
	if _s._plyr._ltst_keep == key1 and _s:k(key2) then
		ret = _.t
	else
		ret = _.f
	end
	return ret
end

