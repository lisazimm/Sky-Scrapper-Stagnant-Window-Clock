local screenWidth = display.contentWidth
local screenHeight = display.contentHeight
local screenCenterX = display.contentCenterX
local screenCenterY = display.contentCenterY

local background = display.newRect( 0, 0, screenWidth, screenHeight ) -- sky
background:setFillColor(0,0,1,.5) -- dark blue
background.x = display.contentWidth/2 --screenCenterX -- center background
background.y = screenCenterY -- center background

local myStar = display.newLine( 200, 90, 227, 165 ) -- found code for Star on Corona display library
myStar:append( 305,165, 243,216, 265,290, 200,245, 135,290, 157,215, 95,165, 173,165, 200,90 )  
myStar.strokeWidth = 8
myStar:setStrokeColor(math.random(0,1), math.random(.5,1), math.random(.8,1), math.random(1,1)) -- each time app launched, star will be a different color
transition.to(myStar, {time = 8500, x = display.contentWidth / 1.25} ) -- I pulled this animtion from code posted on blog to move building and decided to move the star here instead

local myTextBackground = display.newText ("What time does Poetics of the Mobile begin?", 310,320,"Garamond",30)
local myText2Background = display.newText ("At the Unlit Windows", 310,350,"Garamond",30)
local myText3Background = display.newText("LeftBldg : RightBldg",150,530, "Garamond",35)
transition.blink(myText3Background, {time = 1000}) -- blink every second like a clock

local myGrass = display.newRect( 0, 0, screenWidth, 100) -- grass under/behind building
myGrass.x = display.contentCenterX 
myGrass.y = display.contentCenterY * 2
myGrass:setFillColor( 0, .9, .1, .5) -- green 

-- Problem: in trying to group my first bldg, I kept getting errors, so the short building (left) is 
-- made up of individually defined variables and the second building is a group (using tutorial and updating with my values)

local bldgHeight = screenHeight * 0.4 
local bldgWidth = screenWidth * 0.3 
print( "Bldg: " .. bldgWidth .. " x " .. bldgHeight ) 

local myBldg = display.newRect( 0, 0, bldgWidth, bldgHeight)
myBldg.x = display.contentWidth * .25 --/ 2 -- center my building
myBldg.y =  display.contentCenterY * 1.8 --  place bldg at bottom of screen 
myBldg:setFillColor(.5,1) -- gray, appears overtop of sky (bldg in forefront)

myWindows = {} -- code obtained from LeMasters tutorial online and lesson in class
local function windowValueXY (windowValueX,windowValueY)
	local arrayPosition = (windowValueY*bldgWidth) + windowValueX 
	return arrayPosition
end 

local myWindowColumns = 4 -- windows columns and rows
local myWindowRows = 6
local myTotalWindows = {1,28}
local startX=myBldg.x - 100 --display.contentCenterX -100
local startY=myBldg.y - 200  --display.contentCenterY + 65

for j=1,4 do -- four columns
	for k=1,6 do -- six rows 
		local z = windowValueXY(j,k)
		myWindows[z] = display.newRect(startX+j*40,startY+k*45,30,35)  
			 myWindows[z]:setFillColor(1, .8, .2) 
		for j=1,4 do --1,1
			for k=1,3 do -- 1,3fill the first column window of the first three rows
				myWindows[z] = display.newRect(startX+j*40,startY+k*45,30,35)
				myWindows[z]:setFillColor(0,1)
				end
			end
				for j=4,4 do --1,1
					for k=4,6 do -- this blacks out 15 windows to symbolize the hour 15 (3 p.m.)
					myWindows[z] = display.newRect(startX+j*40,startY+k*45,30,35)
					myWindows[z]:setFillColor(0,1)
				end
			end
	end				 	
end	

--Begin second building below
--second building is 6x10
--CREDIT: Second Building's code adapts  template code LeMasters posted to create a different sized building with lights on and off.

local function installWindows( bX, bY, bW, bRC, bH, bFC )

	local bldgX = bX 
	local bldgY = bY 

	local bldgLayers = display.newGroup() 

	local bldgWidth = bW
	local bldgHeight = bH
	local bldgFloorCount = bFC
	local bldgRoomCount = bRC

	local windowWidthToRoomWidthRatio = 1 / 2
	local windowHeightToFloorHeightRatio = 1 / 2 

	local bldgRoomWidth = math.round( bldgWidth / bldgRoomCount )
	local bldgFloorHeight = math.round( bldgHeight / bldgFloorCount )
	local bldgWindowWidth = math.round( bldgRoomWidth * windowWidthToRoomWidthRatio )
	local bldgWindowHeight = math.round( bldgFloorHeight * windowHeightToFloorHeightRatio )

	local roomCenterX = bldgRoomWidth * 0.50
	local roomCenterY = bldgFloorHeight * 0.50

	local remainderX = bldgWidth - ( bldgRoomWidth * bldgRoomCount )
	local remainderY = bldgHeight - ( bldgFloorHeight * bldgFloorCount )
	remainderX = remainderX * 0.5
	remainderY = remainderY * 0.5

	local windowCenterX = bldgWindowWidth * 0.5
	local windowCenterY = bldgWindowHeight * 0.5 
	local windowAnchorX = remainderX - roomCenterX
	local windowAnchorY = remainderY - roomCenterY

	local windowLightsOn = { 1, .8, .2 }
	local windowLightsOff= {0, 0, 0, 1}

	local buildingColor = { .3, .3, .3 } 

	local bldgAdjustX = bldgX + ( bldgWidth * 0.5 ) 

	local windowAdjustX = bldgX + windowAnchorX

	local bldgAdjustY = bldgY - ( bldgHeight * 0.5 )

	local windowAdjustY = bldgY + windowAnchorY - bldgHeight

	local bldgShell = display.newRect( bldgAdjustX, bldgAdjustY, bldgWidth, bldgHeight )
	bldgShell.fill = buildingColor

     bldgLayers:insert(bldgShell) 

	for column = 1, bldgRoomCount do -- second to represent half past the hour (30 windows lit, 30 blacked out)
		for row = 1, bldgFloorCount do
			local xPos = windowAdjustX + (column * bldgRoomWidth) -- here
			local yPos = windowAdjustY + (row * bldgFloorHeight) -- here
			local window = display.newRect (xPos, yPos, bldgWindowWidth, bldgWindowHeight)
			window.fill = windowLightsOn
			bldgLayers:insert(window)
				for column = 1, bldgRoomCount do  -- for columns 1,2,3,4,5,6 
					for row = 6, bldgFloorCount do --  for rows 6,7,8,9,10 
						local xPos = windowAdjustX + (column * bldgRoomWidth) 
						local yPos = windowAdjustY + (row * bldgFloorHeight) 
						local window = display.newRect (xPos, yPos, bldgWindowWidth, bldgWindowHeight)
						window.fill = windowLightsOff -- 6 columns (1-6) * 5 rows (6-10) = 30 window lights off
					end 
				bldgLayers:insert(window)
				end 
	
		end
	end



	return bldgLayers

end

local groundLevel = display.contentHeight * 1.01 -- move to ground
local buildingOne = installWindows( 310, groundLevel, 300, 6, 600, 10 )


