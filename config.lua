
local addon, namespace = ...

local config = {}
namespace.config = config


config["default"] = {
  ["prefix_answers"] = "<DCSpam>: ",
  --if you put this too low you risk getting disconnected
  ["spam_frequency"] = 30, --in seconds
  ["spam_msg"] = "Deposit Coin (1/7 Mythic) is currently recruiting dps for mythic progression. We raid 2 times per week 19:30 - 23:00. We consist of previous top players on the server who now want to raid more casually. /w for more information.",
  
  ["commands"] = {
--    ["!info"] = "Whisper '!info {hm, brf}' for more infos about recruting. Example: '!info mage'.",
--    ["!info mage"] = "highmaul boost",
--    ["!info hm"] = "highmaul boost",
--    ["!info brf"] = "brf boost",
    },
}



--inheritance for the config (dont modify this)
for k,_ in pairs(config) do 
  setmetatable(config[k], config[k])
end
