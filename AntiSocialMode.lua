--Global Vars
isOn = false;			--boolean to check if ASM is on

local greeting = CreateFrame("Frame")													--FUNCTION that greets player on load-in
	greeting:RegisterEvent("PLAYER_ENTERING_WORLD");			--Event that check if player loaded in
	greeting:SetScript("OnEvent", function()					
		if(isOn == false) then									--If ASM mode is on:
			print("ASM: Anti-Social Mode is currently OFF. Press the Anti-Social Mode Button to activate ASM.");
		elseif(isOn == true) then								--If ASM mode is off:
			print("ASM: Anti-Social Mode is currently ON. Press the Anti-Social Mode Button to de-activate ASM.");
		end
	end)

local button = CreateFrame("Button", "MyButton", UIParent, "UIPanelButtonTemplate")		--FUNCTION that creates button and handles its use
	button:SetMovable(true);									--button can be moved
	button:SetWidth(125);	
	button:SetHeight(25);
	button:SetPoint("TOP");										--point on screen
	button:SetText("Anti-Social Mode");							--button text
	button:RegisterForClicks("AnyUp");							--register all mouse buttons able to click it
	button:SetScript("OnMouseDown", button.StartMoving);		--script for allowing button to move
	button:SetScript("OnMouseUp", button.StopMovingOrSizing);	--script that handles button stop moving
	button:SetClampedToScreen(true);							--disallows button to be dragged off screen
	button:SetScript("OnClick", function()						--function that fires if button is clicked:
		if(isOn == false) then																		--If ASM is OFF:
			isOn = true;																			--set ASM checker to true,
			CreateMacro("AntiSocialMode", "INV_MISC_QUESTIONMARK", "My Anti-Social Mode is turned on. Please refrain from whispering me right now. Thanks!", nil, nil);		--create the macro
			button:SetButtonState("PUSHED");														--sets button to look pushed in
			print("ASM: Anti-Social Mode Activated. Type '/macro' to edit your ASM message!");		--prints to the chat box a message
		elseif(isOn == true) then																	--If ASM if ON:
			isOn = false;																			--set ASM checker to false,					
			DeleteMacro("AntiSocialMode");															--delete the ASM macro
			print("ASM: Anti-Social Mode De-activated.");
		end
	end)


local antiSocial = CreateFrame("Frame")													--FUNCTION that handles whispering back players
	antiSocial:RegisterEvent("CHAT_MSG_WHISPER");										--register CHATMSGWHISPER event
	antiSocial:SetScript("OnEvent", function(self, event, msg, sender, ...)				--script that handles when to send anti-social response whisper
		if(event == "CHAT_MSG_WHISPER" and isOn == true) then							--if addon is on, and a whisper was received,
			SendChatMessage(GetMacroBody("AntiSocialMode"), "WHISPER", nil, sender);	--send a chat message with macro contents
		end
	end)