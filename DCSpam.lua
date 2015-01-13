
local addon, namespace = ...

local DCSpam = {}
namespace.DCSpam = DCSpam


--TODO upvalue more stuff
local C_Timer, GetChannelName = C_Timer, GetChannelName

local function get_trade_channel_id()
  for i = 1, 10 do
    _,name = GetChannelName(i)
    if name then
      if string.find(name, "Trade") then
        return i
      end
    else
      return 0
    end
  end
end


function DCSpam.init(self, config)
  local object = CreateFrame("Frame", nil, UIParent)
  
  object.config = config or namespace.config["default"]
  
  --use meta tables for the inheritance
  local parent = {DCSpam, getmetatable(object).__index}
  setmetatable(object, DCSpam)
  DCSpam.__index = function(t,k)
    for i=1, #parent do
      local v = parent[i][k]
      if v then
        return v
      end
    end
  end
  
  object.active = false
  
  object.filter = function(chatframe, event, msg, author, ...) 
    object:filter_whisper_inform(chatframe, event, msg, author, ...)
  end
  
  object:SetScript("OnEvent", DCSpam.update)
  
  --slash command
  SLASH_DCSPAM1 = "/dcspam"
  SlashCmdList["DCSPAM"] =  function(msg, edit_box) 
    object:slash_handler(msg, edit_box) 
  end
  
  return object
end


function DCSpam.start(self)
  ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", self.filter)
  self:RegisterEvent("CHAT_MSG_WHISPER")
  self:RegisterEvent("CHAT_MSG_WHISPER_INFORM")
  self:spam()
  print("[!] Started spam")
  self.active = true
end


function DCSpam.stop(self)
  self:UnregisterAllEvents()
  ChatFrame_RemoveMessageEventFilter("CHAT_MSG_WHISPER_INFORM", self.filter)
  print("[!] Stoped spam")
  self.active = false
end


function DCSpam.spam(self)
  C_Timer.After(self.config["spam_frequency"], function()
    if self.active then
      self:spam()
    end
  end)
  SendChatMessage(self.config["spam_msg"], "CHANNEL", nil, get_trade_channel_id())
end


function DCSpam.update(self, event, msg, author, language, status)
  if event == "CHAT_MSG_WHISPER" then
    for k,v in pairs(self.config["commands"]) do
      if k == string.lower(msg) then
        SendChatMessage(self.config["prefix_answers"]..v ,"WHISPER",nil, author);
        break;
      end
    end
--  elseif event == "CHAT_MSG_WHISPER_INFORM" then
    --don't need to do anything here
  end
end

--TODO not hidding the messages as intended!
function DCSpam.filter_whisper_inform(self, chatframe, event, msg, author, ...)
  if string.sub(msg, 1, string.len(self.config["prefix_answers"])) == self.config["prefix_answers"] then
    --print("true")
    return true
  else
     --print("false")
    return false
  end
end


function DCSpam.slash_handler(self, msg, edit_box)
  if msg == "start" then
    self:start()
  elseif msg == "stop" then
    self:stop()
  else
    print("[!] Use /dcspam {start, stop}")
  end
end


print(DCSpam)
DCSpam:init()

--
--
--DCSpam = LibStub("AceAddon-3.0"):NewAddon("DCSpam","AceConsole-3.0", "AceEvent-3.0");
--
--local _G = getfenv(0);	
--
--local DCSpamFrame = CreateFrame("Frame", nil, UIParent);
--
--local d = DCSpamSettings;
--
--local command = d.command;
--local prefix_answers = d.prefix_answers
--local spam_frequency = d.spam_frequency
--local spam_msg = d.spam_msg
--
----this will prob only work on english clients
--
--
--local function cmd_options(input)
--	print(input)
--end
--
--function DCSpam:OnInitialize()
--	DCSpamFrame.frequency = spam_frequency; --you can only write a message every 30 seconds
--	DCSpamFrame.lastUpdate = DCSpamFrame.frequency;
--	
--	options = {
--		name = "DCSpam cmd options",
--		type = "group",
--		args = {
--			start = {
--				name = "Start",
--				desc = "Start spaming in the Trade chat.",
--				type = "execute",
--				order = 1,
--				func = function(v)
--					print("Starting.")
--					DCSpam:Start()
--				end,
--			},
--			stop = {
--				name = "Stop",
--				desc = "Stop spaming in the Trade chat.",
--				type = "execute",
--				order = 2,
--				func = function(v)
--					print("Stopping.")
--					DCSpam:Stop()
--				end,
--			},
--		}
--	}
--	
--	--CMD options
--	LibStub("AceConfig-3.0"):RegisterOptionsTable("DCSpam", options, {"dcspam", "dcs"});
--end
--
--function DCSpam:OnEnable()
--	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", filter_whisper_inform)
--	self:RegisterEvent("CHAT_MSG_WHISPER")
--	self:RegisterEvent("CHAT_MSG_WHISPER_INFORM")
--end
--
--function DCSpam:OnDisable()
--	self:UnregisterEvent("CHAT_MSG_WHISPER")
--	self:UnregisterEvent("CHAT_MSG_WHISPER_INFORM")
--	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_WHISPER_INFORM", filter_whisper_inform)
--	DCSpamFrame:SetScript("OnUpdate", nil);
--end
--
--function DCSpam:Start()
--	DCSpamFrame:SetScript("OnUpdate", function(...) DCSpam:Spam(...); end);
--end
--
--function DCSpam:Stop()
--	DCSpamFrame:SetScript("OnUpdate", nil);
--end
--
--function DCSpam:CHAT_MSG_WHISPER(event, msg, author, language, status)
--	for k,v in pairs(command) do
--		if k == string.lower(msg) then
--			--SendChatMessage(prefix_answers..v ,"WHISPER",nil, author);
--			break;
--		end
--	end
--end
--
--function DCSpam:CHAT_MSG_WHISPER_INFORM(event)
--	--nothing to do here atm
--end
--
--function DCSpam:Spam(self, elapsed)
--	if DCSpamFrame.lastUpdate < DCSpamFrame.frequency then
--		DCSpamFrame.lastUpdate = DCSpamFrame.lastUpdate + elapsed;
--		return;
--	end
--	
--	SendChatMessage(spam_msg ,"CHANNEL" ,nil ,get_trade_channel_id());
--	
--	DCSpamFrame.lastUpdate = 0;
--end
--
