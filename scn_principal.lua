---------------------------------------------------------------------------------
--
-- testscreen1.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local tableView = require("tableView")
local ui = require("ui")
local scene = storyboard.newScene()

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

    local image
-- Israel Ini
    --screenOffsetW, screenOffsetH = display.contentWidth -  display.viewableContentWidth, display.contentHeight - display.viewableContentHeight
    local myList1

    --setup each row as a new table, then add title, subtitle, and image

    --setup the table
    local lstScene1 = {}  --note: the declaration of this variable was moved up higher to broaden its scope
    local lstScreen1 = {}  --note: the declaration of this variable was moved up higher to broaden its scope
    local seq = 0
    seq = seq + 1
    lstScene1[seq] = {}
    lstScene1[seq].title = "Restaurantes"
    lstScene1[seq].subtitle = "matar a fome"
    lstScene1[seq].image = "restaurante.png"
    lstScene1[seq].category = "meu app"
    lstScreen1[seq] = {}
    lstScreen1[seq].page = "restaurantes.html"
    lstScreen1[seq].scene = "scene4"

    seq = seq + 1
    lstScene1[seq] = {}
    lstScene1[seq].title = "Praias"
    lstScene1[seq].subtitle = "banhar-se e brincar"
    lstScene1[seq].image = "praias2.png"
    lstScene1[seq].category = "meu app"
    lstScreen1[seq] = {}
    lstScreen1[seq].page = "praias.html"
    lstScreen1[seq].scene = "scene4"

    seq = seq + 1
    lstScene1[seq] = {}
    lstScene1[seq].title = "Mapa"
    lstScene1[seq].subtitle = "ilha com zooom"
    lstScene1[seq].image = "lic_mapa.png"
    lstScene1[seq].category = "meu app"
    lstScreen1[seq] = {}
    lstScreen1[seq].page = "mapa.html"
    lstScreen1[seq].scene = "scene4"

    seq = seq + 1
    lstScene1[seq] = {}
    lstScene1[seq].title = "Informações"
    lstScene1[seq].subtitle = "Para se achar"
    lstScene1[seq].image = "info.png"
    lstScene1[seq].category = "meu app"
    lstScreen1[seq] = {}
    lstScreen1[seq].page = "info.html"
    lstScreen1[seq].scene = "scene4"

    seq = seq + 1
    lstScene1[seq] = {}
    lstScene1[seq].title = "Cachoeiras"
    lstScene1[seq].subtitle = "Para curtir"
    lstScene1[seq].image = "cachoeira.png"
    lstScene1[seq].category = "meu app"
    lstScreen1[seq] = {}
    lstScreen1[seq].page = "cachoeira.html"
    lstScreen1[seq].scene = "scn_sos_web.lua"



    local headers = { "meu app"}
    local topBoundary = display.screenOriginY + 40 -- aqui define o topo da lista
    local bottomBoundary = display.screenOriginY + 0
    

local function listButtonRelease( event )
	print("click")
	self = event.target
	local id = self.id
	-- faz sumir o botão
    --transition.to(PetBtn, {time=iTempoTransicao, alpha=0 })
    if lstScreen1[id].scene ~= nil then
        local storyboard = require "storyboard"
        local widget = require "widget"

        -- load first scene
		htmlpage = lstScreen1[id].page 
		print(htmlpage)
        -- load first scene
        storyboard.gotoScene( true, "scn_sos_web", "slideLeft", iTempoTransicao )
        return true
     end   

end



-- Funcao Principal onde montar a tela
function scene:createScene( event )
	print( "\n1: createScene event" )
    sceneVoltar = "exit"

	local screenGroup = self.view
	
	image = display.newImage( "bg.jpg" )
	screenGroup:insert( image )

    -- Israel Implementation
    local navBar = ui.newButton{
        default = "navBar.png",
        onRelease = scrollToTop
    }
   
    navBar.x = display.contentWidth*.5
    navBar.y = math.floor(display.screenOriginY + navBar.height*0.5)

    local navHeader = display.newText(PetData.titulo, 0, 0, native.systemFontBold, 14)
    navHeader:setTextColor(255, 255, 255)
    navHeader.x = display.contentWidth*.5
    navHeader.y = navBar.y    
    
    local PetBtn = ui.newButton{ 
        default = "ico.png", 
        over = "ico_over.png", 
    }    

    print(PetBtn.width/2)
    PetBtn.x = math.floor( PetBtn.width/2) + display.screenOriginX
    PetBtn.y = navBar.y 
    
    
   
    --iPad: setup a color fill for selected items
    local selected = display.newRect(0, 0, 50, 50)  --add acolor fill to show the selected item
    selected:setFillColor(67,141,241,180)  --set the color fill to light blue
    selected.isVisible = false  --hide color fill until needed

    myList1 = tableView.newList{
        data=lstScene1, 
        default="listItemBg.png",
        over="listItemBg_over.png",
        onRelease=listButtonRelease,
        top=topBoundary,
        bottom=bottomBoundary,
        cat="category",
        order=headers,
        categoryBackground="catBg.png",
        --backgroundColor={ 255, 255, 255 },  
        --commented this out because we're going to add it down below
        callback = function( row )
                             local g = display.newGroup()

                             local img = display.newImage(row.image)
                             g:insert(img)
                             img.x = math.floor(img.width*0.5 + 6)
                             img.y = math.floor(img.height*0.5) 

                             local title =  display.newText( row.title, 0, 0, native.systemFontBold, 14 )
                             title:setTextColor(0, 0, 0)
                             --title:setTextColor(255, 255, 255)
                             g:insert(title)
                             title.x = title.width*0.5 + img.width + 6
                             title.y = 30

                             local subtitle =  display.newText( row.subtitle, 0, 0, native.systemFont, 10 )
                             subtitle:setTextColor(80,80,80)
                             --subtitle:setTextColor(180,180,180)
                             g:insert(subtitle)
                             subtitle.x = subtitle.width*0.5 + img.width + 6
                             subtitle.y = title.y + title.height + 6

                             return g   
                      end 
    }    
    
    local listBackground = display.newRect( 0, 0, myList1.width, myList1.height )
    listBackground:setFillColor(255,255,255)
    myList1:insert(1,listBackground)    
    
    screenGroup:insert( myList1 )
    screenGroup:insert( navBar )
    screenGroup:insert( navHeader )
    screenGroup:insert( PetBtn )

end

local function scrollToTop()
	myList1:scrollTo(topBoundary-1)
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	-- remove previous scene's view
	print( "1: enterScene event" )
	storyboard.purgeScene( sLastScene )
    sLastScene = "scn_principal"
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	-- remove touch listener for image
	image:removeEventListener( "enterFrame", myList1 )
	print( "1: exitScene event" )
end

-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	print( "((destroying scene 1's view))" )
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