
local addon, namespace = ...

local config = {}
namespace.config = config


config["default"] = {
  ["prefix_answers"] = "<DCSpam>: ",
  --if you put this too low you risk getting disconnected
  ["spam_frequency"] = 40, --in seconds
  ["spam_msg"] = "Deposit Coin is recruting... /w miga",
  
  ["commands"] = {
    ["!info"] = "Whisper '!info {hm, brf}' for more infos about recruting. Example: '!info mage'.",
    ["!info mage"] = "highmaul boost",
    ["!info hm"] = "highmaul boost",
    ["!info brf"] = "brf boost",
    },
}



--inheritance for the config (dont modify this)
for k,_ in pairs(config) do 
  setmetatable(config[k], config[k])
end




--DCSpamSettings = {
--
--	prefix_answers = "<DCSpam>: ",
--	spam_frequency = 40,
--	spam_msg = "Deposit Coin is recruting...",
--
--	command = {
--		["!info"] = "Whisper '!info {ds, fl, legendary}' for more infos about a boost. Example: '!info sinestra'.",
--		["!info sinestra"] = "The price is 100k, you get a Sinestra hc boost(awards prestigious Dragonslayer title). If you have further questions feel free to ask.",
--		["!info fl"] = "The price is 250k, you get a 7/7hc boost, including Firelord + ragnaros mount, any loot you want(exluding boe's & alysrazor mount). If you have further questions feel free to ask.",
--		["!info legendary"] = "Legendary staff boosts. NOTE: This is ONLY a 6/7 hc run! Embers: 4k per ember, Cinders 6/7 hc run: 40k, Siphons 6/7 hc run: 50k. If you have further questions feel free to ask.",
--		["!info ds"] = "The price is 600k, including the mount and the Savior of Azeroth title. You will only be invited for madness hc. If you have further questions feel free to ask.",
--		},
--}