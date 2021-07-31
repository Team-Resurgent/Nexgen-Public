--[[
$module vector2

vector2 module
--]]

local vector2 = {}

local assert = assert
local getmetatable = getmetatable
local setmetatable = setmetatable

local vectorTable = {

	__metatable = 'vector2.metatable',

	__index = function(this, index)
		return this[index:upper()] or this[index:lower()]
	end,

	__add = function(this, secondVector)
		assert(getmetatable(secondVector) == 'vector2.metatable' or type(secondVector) == 'number', 'You can only add a vector2 with another vector2 or a number.')
		local x, y
		if getmetatable(secondVector) == 'vector2.metatable' then
			x, y = secondVector.x, secondVector.y
		else
			x, y = secondVector, secondVector
		end
		x, y = mathAddVector2(this.x, this.y, x, y)
		return vector2.new(x, y)
	end,

	__sub = function(this, secondVector)
		assert(getmetatable(secondVector) == 'vector2.metatable' or type(secondVector) == 'number', 'You can only sub a vector2 with another vector2 or a number.')
		local x, y
		if getmetatable(secondVector) == 'vector2.metatable' then
			x, y = secondVector.x, secondVector.y
		else
			x, y = secondVector, secondVector
		end
		x, y = mathSubtractVector2(this.x, this.y, x, y)
		return vector2.new(x, y)
	end,

	__mul = function(this, secondVector)
		assert(getmetatable(secondVector) == 'vector2.metatable' or type(secondVector) == 'number', 'You can only multiply a vector2 with another vector2 or a number.')
		local x, y
		if getmetatable(secondVector) == 'vector2.metatable' then
			x, y = secondVector.x, secondVector.y
		else
			x, y = secondVector, secondVector
		end
		x, y = mathMultiplyVector2(this.x, this.y, x, y)
		return vector2.new(x, y)
	end,

	__div = function(this, secondVector)
		assert(getmetatable(secondVector) == 'vector2.metatable' or type(secondVector) == 'number', 'You can only divide a vector2 with another vector2 or a number.')
		local x, y
		if getmetatable(secondVector) == 'vector2.metatable' then
			x, y = secondVector.x, secondVector.y
		else
			x, y = secondVector, secondVector
		end
		x, y = mathDivideVector2(this.x, this.y, x, y)
		return vector2.new(x, y)
	end,

	__tostring = function(this)
		return ('vector2 %f, %f'):format(this.x, this.y)
	end

}

--[[
% unpack()

Used to unpack vector into its 2 elements.

: (number) x element
: (number) y element
--]]
function vector2.new(x, y)
	
	this = {}

	this.x = x or 0
	this.y = y or 0

    function this.unpack()
		return (this.x) (this.y)
	end

--[[
% lerp(secondVector, alpha)

Used to interpolate between vector value and an other

: (vector2) vector
--]]
	function this.lerp(secondVector, alpha)
		local alpha = type(alpha) == 'number' and alpha or 0
		return vector2.new((secondVector.x - this.x) * alpha + this.x, (secondVector.y - this.y) * alpha + this.y)
	end

--[[
% invertY(value)

Used to offset y value e.g. value - y.

@ [optional] value (number) defaults to 0

: (vector2) vector
--]]
	function this.invertY(value)
		local yOffset = value or 0
		return vector2.new(this.x, yOffset - this.y)
	end

--[[
% invertX(value)

Used to offset y value e.g. value - x.

@ [optional] value (number) defaults to 0

: (vector2) vector
--]]
	function this.invertX(value)
		local xOffset = value or 0
		return vector2.new(xOffset - this.x, this.y)
	end

	return setmetatable(this, vectorTable)

end

return vector2