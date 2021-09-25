--[[
$module color4

color4 module
--]]

local color4 = {}

local assert = assert
local getmetatable = getmetatable
local setmetatable = setmetatable

local colorTable = {

	__metatable = 'color4.metatable',

	__index = function(this, index)
		return this[index:upper()] or this[index:lower()]
	end,

	__add = function(this, secondColor)
		assert(getmetatable(secondColor) == 'color4.metatable' or type(secondColor) == 'number', 'You can only add a color4 with another color4 or a number.')
		local r, g, b, a
		if getmetatable(secondColor) == 'color4.metatable' then
			r, g, b, a = secondColor.r, secondColor.g, secondColor.b, secondColor.a
		else
			r, g, b, a = secondColor, secondColor, secondColor, secondColor
		end
		r, g, b, a = mathAddColor4(this.r, this.g, this.b, this.a, r, g, b, a)
		return color4.new(r, g, b, a)
	end,

	__sub = function(this, secondColor)
		assert(getmetatable(secondColor) == 'color4.metatable' or type(secondColor) == 'number', 'You can only sub a color4 with another color4 or a number.')
		local r, g, b, a
		if getmetatable(secondColor) == 'color4.metatable' then
			r, g, b, a = secondColor.r, secondColor.g, secondColor.b, secondColor.a
		else
			r, g, b, a = secondColor, secondColor, secondColor, secondColor
		end
		r, g, b, a = mathSubtractColor4(this.r, this.g, this.b, this.a, r, g, b, a)
		return color4.new(r, g, b, a)
	end,

	__mul = function(this, secondColor)
		assert(getmetatable(secondColor) == 'color4.metatable' or type(secondColor) == 'number', 'You can only multiply a color4 with another color4 or a number.')
		local r, g, b, a
		if getmetatable(secondColor) == 'color4.metatable' then
			r, g, b, a = secondColor.r, secondColor.g, secondColor.b, secondColor.a
		else
			r, g, b, a = secondColor, secondColor, secondColor, secondColor
		end
		r, g, b, a = mathMultiplyColor4(this.r, this.g, this.b, this.a, r, g, b, a)
		return color4.new(r, g, b, a)
	end,

	__div = function(this, secondColor)
		assert(getmetatable(secondColor) == 'color4.metatable' or type(secondColor) == 'number', 'You can only divide a color4 with another color4 or a number.')
		local r, g, b, a
		if getmetatable(secondColor) == 'color4.metatable' then
			r, g, b, a = secondColor.r, secondColor.g, secondColor.b, secondColor.a
		else
			r, g, b, a = secondColor, secondColor, secondColor, secondColor
		end
		r, g, b, a = mathDivideColor4(this.r, this.g, this.b, this.a, r, g, b, a)
		return color4.new(r, g, b, a)
	end,

	__tostring = function(this)
		return ('color4 %f, %f, %f, %f'):format(this.r, this.g, this.b, this.a)
	end

}

--[[
% new(r, g, b, a)

Used to create a new color4.

@ r (number) r element in range of 0 to 1
@ g (number) g element in range of 0 to 1
@ b (number) b element in range of 0 to 1
@ a (number) a element in range of 0 to 1

: (color4) color
--]]
function color4.new(r, g, b, a)
	
	this = {}

	this.r = r or 0
	this.g = g or 0
	this.b = b or 0
	this.a = a or 0

--[[
% unpack()

Used to unpack color into its 4 elements.

: (number) r element
: (number) g element
: (number) b element
: (number) a element
--]]
    function this.unpack()
		return (this.r) (this.g) (this.b) (this.a)
	end

--[[
% lerp(secondColor, alpha)

Used to interpolate between color value and an other

: (color4) color
--]]
	function this.lerp(secondColor, alpha)
		local alpha = type(alpha) == 'number' and alpha or 0
		return color4.new((secondColor.r - this.r) * alpha + this.r, (secondColor.g - this.g) * alpha + this.g, (secondColor.b - this.b) * alpha + this.b, (secondColor.a - this.a) * alpha + this.a)
	end

	return setmetatable(this, colorTable)

end

return color4