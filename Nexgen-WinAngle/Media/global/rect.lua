--[[
$module rect

rect module
--]]

local rect = {}

local assert = assert
local getmetatable = getmetatable
local setmetatable = setmetatable

local rectTable = {

	__metatable = 'rect.metatable',

	__index = function(this, index)
		return this[index:upper()] or this[index:lower()]
	end,

	__tostring = function(this)
		return ('rect %f, %f, %f, %f'):format(this.x, this.y, this.width, this.height)
	end

}

--[[
% new(x, y, width, height)

Used to create a new vector4.

@ x (number) x element
@ y (number) y element
@ width (number) width element
@ height (number) height element

: (rect) rect
--]]
function rect.new(x, y, width, height)
	
	this = {}

	this.x = x or 0
	this.y = y or 0
	this.width = width or 0
	this.height = height or 0

--[[
% unpack()

Used to unpack vector into its 3 elements.

: (number) x element
: (number) y element
: (number) width element
: (number) height element
--]]
    function this.unpack()
		return (this.x) (this.y) (this.width) (this.height)
	end

	return setmetatable(this, rectTable)

end

return rect