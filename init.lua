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

	local user = ya.user_name(h.cha.uid) or h.cha.uid
	local group = ya.group_name(h.cha.gid) or h.cha.gid

	return ui.Span(user .. ":" .. group .. " ")
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
	setup = function(_, _)
		Status.render = function(self, area)
			self.area = area

			local left = ui.Line({ self:mode() })
			local right = ui.Line({ self:permissions(), ui.Span(" "), nlink(), owner(), mtime(), self:position() })
			return {
				ui.Paragraph(area, { left }),
				ui.Paragraph(area, { right }):align(ui.Paragraph.RIGHT),
				table.unpack(Progress:render(area, right:width())),
			}
		end
	end,
}
