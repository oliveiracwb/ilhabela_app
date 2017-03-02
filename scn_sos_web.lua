---------------------------------------------------------------------------------
-- scene3.lua
-- Web View com SOS - Socorros emergenciais
---------------------------------------------------------------------------------
local storyboard = require( "storyboard" )
local tableView = require("tableView")
local ui = require("ui")
local scene = storyboard.newScene()

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
local backBtn

local function onSceneBack ( event )
    if event.phase == "ended" then
      storyboard.gotoScene( true, sceneVoltar, "slideRight", iTempoTransicao  )
    end
    return true
end

-- Funcao Principal onde montar a tela
function scene:createScene( event )
    sceneVoltar = "scn_principal"
	print( "\n4: createScene event" )
	local screenGroup = self.view
	
    -- Israel Implementation
    local navBar = ui.newButton{
        default = "navBar.png"
    }
   
    navBar.x = display.contentWidth*.5
    navBar.y = math.floor(display.screenOriginY + navBar.height*0.5)

    local navHeader = display.newText("Socorros Emergenciais", 0, 0, native.systemFontBold, 14)
    navHeader:setTextColor(255, 255, 255)
    navHeader.x = display.contentWidth*.5
    navHeader.y = navBar.y    
    
    local backBtn = ui.newButton{ 
        default = "backButton.png", 
        over = "backButton_over.png",
        onRelease = onSceneBack
    } 
    
    backBtn.x = math.floor( backBtn.width/2) + display.screenOriginX
    backBtn.y = navBar.y 
   
    local options =
    {
        hasBackground=true,
        baseUrl=system.ResourceDirectory,
        urlRequest=listener
    }    local bordaTop = navBar.contentHeight + 3
    local bordaLeft = 4
    local xWidthPos = display.viewableContentWidth - bordaLeft * 2
    local yHeightPos = display.viewableContentHeight - bordaTop 

    local webView = native.newWebView (  bordaLeft+ display.screenOriginX, bordaTop , xWidthPos,  yHeightPos )
    webView:request( htmlpage, system.ResourceDirectory )
    
    local isSimulator = "simulator" == system.getInfo("environment")       
    if isSimulator then
       local curView = display.newRect(  bordaLeft+ display.screenOriginX, bordaTop , xWidthPos,  yHeightPos )
       curView:setFillColor(red, 20, 150, 100); 
       screenGroup:insert( curView )
    end
     
    -------->>
    screenGroup:insert( webView )
    screenGroup:insert( navBar )
    screenGroup:insert( navHeader )
    screenGroup:insert( backBtn )
    -- posiciona onde deveria haver o webview
end
 

function scene:enterScene( event )
	-- remove previous scene's view
	print( "4: enterScene event" )
	storyboard.purgeScene( sLastScene )
    sLastScene = "scn_sos_web"
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	-- remove touch listener for image
 	print( "4: exitScene event" )
	-- reset label text
end

-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	print( "((destroying scene 3's view))" )
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )
-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )
-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )
-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )
---------------------------------------------------------------------------------

return scene