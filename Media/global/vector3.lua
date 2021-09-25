--[[
$module vector3

vector3 module
--]]

local vector3 = {}

local assert = assert
local getmetatable = getmetatable
local setmetatable = setmetatable

local vectorTable = {

	__metatable = 'vector3.metatable',

	__index = function(this, index)
		return this[index:upper()] or this[index:lower()]
	end,

	__add = function(this, secondVector)
		assert(getmetatable(secondVector) == 'vector3.metatable' or type(secondVector) == 'number', 'You can only add a vector3 with another vector3 or a number.')
		local x, y, z
		if getmetatable(secondVector) == 'vector3.metatable' then
			x, y, z = secondVector.x, secondVector.y, secondVector.z
		else
			x, y, z = secondVector, secondVector, secondVector
		end
		x, y, z = mathAddVector3(this.x, this.y, this.z, x, y, z)
		return vector3.new(x, y, z)
	end,

	__sub = function(this, secondVector)
		assert(getmetatable(secondVector) == 'vector3.metatable' or type(secondVector) == 'number', 'You can only sub a vector3 with another vector3 or a number.')
		local x, y, z
		if getmetatable(secondVector) == 'vector3.metatable' then
			x, y, z = secondVector.x, secondVector.y, secondVector.z
		else
			x, y, z = secondVector, secondVector, secondVector
		end
		x, y, z = mathSubtractVector3(this.x, this.y, this.z, x, y, z)
		return vector3.new(x, y, z)
	end,

	__mul = function(this, secondVector)
		assert(getmetatable(secondVector) == 'vector3.metatable' or type(secondVector) == 'number', 'You can only multiply a vector3 with another vector3 or a number.')
		local x, y, z
		if getmetatable(secondVector) == 'vector3.metatable' then
			x, y, z = secondVector.x, secondVector.y, secondVector.z
		else
			x, y, z = secondVector, secondVector, secondVector
		end
		x, y, z = mathMultiplyVector3(this.x, this.y, this.z, x, y, z)
		return vector3.new(x, y, z)
	end,

	__div = function(this, secondVector)
		assert(getmetatable(secondVector) == 'vector3.metatable' or type(secondVector) == 'number', 'You can only divide a vector3 with another vector3 or a number.')
		local x, y, z
		if getmetatable(secondVector) == 'vector3.metatable' then
			x, y, z = secondVector.x, secondVector.y, secondVector.z
		else
			x, y, z = secondVector, secondVector, secondVector
		end
		x, y, z = mathDivideVector3(this.x, this.y, this.z, x, y, z)
		return vector3.new(x, y, z)
	end,

	__tostring = function(this)
		return ('vector3 %f, %f, %f'):format(this.x, this.y, this.z)
	end

}

--[[
% new(x, y, z)

Used to create a new vector3.

@ x (number) x element
@ y (number) y element
@ z (number) z element

: (vector3) vector
--]]
function vector3.new(x, y, z)
	
	this = {}

	this.x = x or 0
	this.y = y or 0
	this.z = z or 0

--[[
% unpack()

Used to unpack vector into its 3 elements.

: (number) x element
: (number) y element
: (number) z element
--]]
    function this.unpack()
		return (this.x) (this.y) (this.z)
	end

--[[
% lerp(secondVector, alpha)

Used to interpolate between vector value and an other

: (vector3) vector
--]]
	function this.lerp(secondVector, alpha)
		local alpha = type(alpha) == 'number' and alpha or 0
		return vector3.new((secondVector.x - this.x) * alpha + this.x, (secondVector.y - this.y) * alpha + this.y, (secondVector.z - this.z) * alpha + this.z)
	end

--[[
% invertY(value)

Used to offset y value e.g. value - y.

@ [optional] value (number) defaults to 0

: (vector3) vector
--]]
	function this.invertY(value)
		local yOffset = value or 0
		return vector3.new(this.x, yOffset - this.y, this.z)
	end

--[[
% invertX(value)

Used to offset x value e.g. value - x.

@ [optional] value (number) defaults to 0

: (vector3) vector
--]]
	function this.invertX(value)
		local xOffset = value or 0
		return vector3.new(xOffset - this.x, this.y, this.z)
	end		

--[[
% dot(secondVector)

Used to calculate dot product of vector value and an other

: (vector3) vector
--]]
	function this.dot(secondVector)
		return mathDotvector3(this, secondVector)
	end

--[[
% cross(secondVector)

Used to calculate cross of vector value and an other

: (vector3) vector
--]]
	function this.cross(secondVector)
		local x, y, z = mathCrossvector3(this, secondVector)
		return vector3.new(x, y, z)
	end

	return setmetatable(this, vectorTable)

end

--[[
% normal(vector3)

Used to normalize a vector3.

: (vector3) normalized vector
--]]
function vector3.normal(vector3)
	
	local x, y, z = mathNormalvector3(vector3)
	return vector3.new(x, y, z)

end

return vector3