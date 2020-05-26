local log = require("log")
local api = require("coreApi")
local json = require("json")
local http = require("http")

function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end

function ReceiveGroupMsg(CurrentQQ, data)
    if data.FromGroupId ~= 818316898 then
        if string.find(data.Content, '妹子') 
            or string.find(data.Content, '色图') 
            or string.find(data.Content, '美女') then
           api.Api_SendMsg(
               CurrentQQ,
                {
                  toUser = data.FromGroupId,
                  sendToType = 2,
                  sendMsgType = "PicMsg",
                  content = "",
                  groupid = 0,
                  atUser = 0,
                  picUrl = "http://127.0.0.1:8080/mzt/?both=1",
                  picBase64Buf = "",
                  fileMd5 = ""
                }
           )
        end
    end
    return 1
end

function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end
