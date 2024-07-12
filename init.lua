local function spacer()
	return ui.Span(" ")
end

local function nlink()
	local h = cx.active.current.hovered
	if not h then
		return ui.Span("")
	end

	if not h.cha.nlink then
		return ui.Span("")
	end

	return ui.Span(h.cha.nlink .. " ")
end

local function owner()
	local h = cx.active.current.hovered
	if not h then
		return ui.Span("")
	end

	local owner = Linemode:owner(h)
	if owner:width() == 0 then
		return ui.Span("")
	end

	return ui.Line({ owner, ui.Span(" ") })
end

local function mtime()
	local h = cx.active.current.hovered
	if not h then
		return ui.Span("")
	end

	if not h.cha.modified then
		return ui.Span("")
	end

	return ui.Span(os.date("%Y-%m-%d %H:%M", h.cha.modified // 1) .. " ")
end

return {
	setup = function()
		Status:children_remove(2, Status.LEFT) -- size
		Status:children_remove(3, Status.LEFT) -- name
		Status:children_remove(5, Status.RIGHT) -- percentage

		Status:children_add(spacer, 1100, Status.RIGHT)
		Status:children_add(nlink, 1200, Status.RIGHT)
		Status:children_add(owner, 1300, Status.RIGHT)
		Status:children_add(mtime, 1400, Status.RIGHT)
	end,
}
