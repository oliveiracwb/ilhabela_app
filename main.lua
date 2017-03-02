-- Demonstrates how to create a list view using the Table View Library.
-- A list view is a collection of content organized in rows that the user
-- can scroll up or down on touch. Tapping on each row can execute a 
-- custom function.

PetData = {
    titulo = "Ilhabela" ,
    nome = "Para Perdidos" ,
    facebook = "www.facebook.com/eminen"
}

iTempoTransicao = 500
sLastScene = "scene0"
sceneVoltar = "exit"
htmlpage = ""


display.setStatusBar( display.HiddenStatusBar ) 

--initial values
screenOffsetW, screenOffsetH = display.contentWidth -  display.viewableContentWidth, display.contentHeight - display.viewableContentHeight
local  backBtn, detailScreenText, petIcon

local background = display.newRect(0, 0, display.contentWidth, display.contentHeight)
background:setFillColor(77, 77, 77)

local storyboard = require ("storyboard")
local widget = require ("widget")

function onBackButtonPressedAtMap(e)
    if (e.phase == "down" and e.keyName == "menu") then  
        storyboard.gotoScene( true, "scene4", "slideRight", iTempoTransicao - 100 )
    elseif (e.phase == "down" and e.keyName == "back") then
        downPress = true
        return true
    else 
        if (e.phase == "up" and e.keyName == "back" and downPress) then
--        if (e.phase == "ended"  and e.keyName == "back" and downPress) then
        	-- Código Voltar aqui
            downPress = false
            if sceneVoltar ~= "exit" then
               storyboard.gotoScene( true, sceneVoltar, "slideRight", iTempoTransicao - 100 )
               return true
            else
               Runtime:removeEventListener( "key", onBackButtonPressedAtMap )
			   storyboard.gotoScene( "blank", "zoomInOutFade", iTempoTransicao )
               return true
            end            
        end
    end
    return false;
end

  local isAndroid = "Android" == system.getInfo("platformName")       
  if isAndroid then
     Runtime:addEventListener( "key", onBackButtonPressedAtMap );
  end
  
print(system.getInfo("environment"))
print(system.getInfo("platformName"))
  
    

storyboard.gotoScene( "scn_principal", "fade", iTempoTransicao )
 