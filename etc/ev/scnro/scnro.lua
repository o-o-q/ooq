log.script("scnro.lua")

Scnro = {}

Scnro.tst = {
	function ()
		Obj.fall.tst()
		D.c("sanae")
		D._("わーい")
		D._("こんかいは\nマップ の くかく を\nかくちょう したよ")
		D.o("くわしくは\nどうが の せつめいらん を みねて")
	end,
	--[[
	function ()
		Wa._(3)
	end,
	function ()
		D.c("sanae")
		D.o("わたげ は\nいってい かくりつ で\nたね になるよ")
	end,
	--]]
}

Scnro.chara_fall = {
	function ()
		Obj.fall.chara()
		D.c("sanae")
		D.o("わー")
	end,
	---[[
	function ()
		Wa._(1.5)
	end,
	function ()
		D.c("sanae")
		D._("！")
		D._("わたしと いっしょに ...")
		D._("みんなも おちてきた！")
		D.o("たのしいね")
	end,
	--]]
}

Scnro.fire_fall = {
	function ()
		Obj.fall.fire()
		D.c("sanae")
		D.o("わー")
	end,
	---[[
	function ()
		Wa._(1.5)
	end,
	function ()
		D.c("sanae")
		D._("！")
		D._("わたしと いっしょに ...")
		D._("ひ が おちてきた！")
		D._("き の ブロック には\nもえ うつっちゃう から")
		D.o("つくっちゃ だめだよ！")
	end,
	--]]
}

Scnro.tree_fall = {
	function ()
		Obj.fall.tree()
		D.c("sanae")
		D.o("わー")
	end,
	---[[
	function ()
		Wa._(1.5)
	end,
	function ()
		D.c("sanae")
		D._("！")
		D._("わたしと いっしょに ...")
		D._("たくさんの きが ...")
		D._("ふってきてる！")
		D._("きっと これは")
		D._("かみさまの おめぐみよ")
		D.o("いっぱい しゅうかく\nしちゃいましょう！")
	end,
	--]]
}

Scnro.game_start = {
	function ()
		Obj.fall.game_start()
		D.c("sanae")
		D.o("わー")
	end,
	---[[
	function ()
		Wa._(1.5)
	end,
	function ()
		D.c("sanae")
		D._("！")
		D._("...")
		D._("えーと ...")
		D._("ここは ...")
		D.o("どこかしら ... ？")
	end,
	function ()
		Wa._(1.5)
	end,
	function ()
		D.c("sanae")
		D._("うーん ...")
		D._("ここが どこかは ")
		D._("...")
		D._("わからない")
		D._("だけど")
		D._("...")
		D._("わたし")
		D._("きめた！")
		D._("ここで")
		D._("くらしていくわ")
		D._("...")
		D._("だって ...")
		D._("ここは とても")
		D._("へいわ そうな ところだし")
		D._("ここが どこかなんて")
		D._("きにしないわ")
		D._("そんなこと")
		D.o("ちっとも\nきにしないわ！")
	end,
	function ()
		Wa._(1.5)
	end,
	function ()
		D.c("sanae")
		D._("うーん ...")
		D._("わたしと いっしょに")
		D._("いろんな ものが\nおちてきた")
		D._("...")
		D._("とても ... ふしぎなことね")
		D._("...")
		D._("だけど")
		D._("そんなこと きにしないわ")
		D._("わたし")
		D._("かつよう できる ものは\nなんだって かつよう して")
		D.o("ここで くらしていくの")
	end,
	--]]
}
