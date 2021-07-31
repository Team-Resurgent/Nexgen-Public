--[[
$module color3

color3 module
--]]

local color3 = {}

local assert = assert
local getmetatable = getmetatable
local setmetatable = setmetatable

local colorTable = {

	__metatable = 'color3.metatable',

	__index = function(this, index)
		return this[index:upper()] or this[index:lower()]
	end,

	__add = function(this, secondColor)
		assert(getmetatable(secondColor) == 'color3.metatable' or type(secondColor) == 'number', 'You can only add a color3 with another color3 or a number.')
		local r, g, b
		if getmetatable(secondColor) == 'color3.metatable' then
			r, g, b = secondColor.r, secondColor.g, secondColor.b
		else
			r, g, b = secondColor, secondColor, secondColor
		end
		r, g, b = mathAddColor3(this.r, this.g, this.b, r, g, b)
		return color3.new(r, g, b)
	end,

	__sub = function(this, secondColor)
		assert(getmetatable(secondColor) == 'color3.metatable' or type(secondColor) == 'number', 'You can only sub a color3 with another color3 or a number.')
		local r, g, b
		if getmetatable(secondColor) == 'color3.metatable' then
			r, g, b = secondColor.r, secondColor.g, secondColor.b
		else
			r, g, b = secondColor, secondColor, secondColor
		end
		r, g, b = mathSubtractColor3(this.r, this.g, this.b, r, g, b)
		return color3.new(r, g, b)
	end,

	__mul = function(this, secondColor)
		assert(getmetatable(secondColor) == 'color3.metatable' or type(secondColor) == 'number', 'You can only multiply a color3 with another color3 or a number.')
		local r, g, b
		if getmetatable(secondColor) == 'color3.metatable' then
			r, g, b = secondColor.r, secondColor.g, secondColor.b
		else
			r, g, b = secondColor, secondColor, secondColor
		end
		r, g, b = mathMultiplyColor3(this.r, this.g, this.b, r, g, b)
		return color3.new(r, g, b)
	end,

	__div = function(this, secondColor)
		assert(getmetatable(secondColor) == 'color3.metatable' or type(secondColor) == 'number', 'You can only divide a color3 with another color3 or a number.')
		local r, g, b
		if getmetatable(secondColor) == 'color3.metatable' then
			r, g, b = secondColor.r, secondColor.g, secondColor.b
		else
			r, g, b = secondColor, secondColor, secondColor
		end
		r, g, b = mathDivideColor3(this.r, this.g, this.b, r, g, b)
		return color3.new(r, g, b)
	end,

	__tostring = function(this)
		return ('color3 %f, %f, %f'):format(this.r, this.g, this.b)
	end

}

--[[
% new(r, g, b)

Used to create a new color3.

@ r (number) r element in range of 0 to 1
@ g (number) g element in range of 0 to 1
@ b (number) b element in range of 0 to 1

: (color3) color
--]]
function color3.new(r, g, b)
	
	this = {}

	this.r = r or 0
	this.g = g or 0
	this.b = b or 0

--[[
% unpack()

Used to unpack color into its 3 elements.

: (number) r element
: (number) g element
: (number) b element
--]]
    function this.unpack()
		return (this.r) (this.g) (this.b)
	end

--[[
% lerp(secondColor, alpha)

Used to interpolate between color value and an other

: (color3) color
--]]
	function this.lerp(secondColor, alpha)
		local alpha = type(alpha) == 'number' and alpha or 0
		return color3.new((secondColor.r - this.r) * alpha + this.r, (secondColor.g - this.g) * alpha + this.g, (secondColor.b - this.b) * alpha + this.b)
	end

	return setmetatable(this, colorTable)

end

return color3