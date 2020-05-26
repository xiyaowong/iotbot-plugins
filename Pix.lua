-- pix 动漫图
local api = require("coreApi")
local http = require("http")

function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end

function ReceiveGroupMsg(CurrentQQ, data)
    if data.Content == 'pix' then
       api.Api_SendMsg(
           CurrentQQ,
            {
              toUser = data.FromGroupId,
              sendToType = 2,
              sendMsgType = "PicMsg",
              content = "",
              groupid = 0,
              atUser = 0,
              picUrl = "http://127.0.0.1:8080/pix/",
              picBase64Buf = "",
              fileMd5 = ""
            }
       )
    end
    return 1
end

function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end
