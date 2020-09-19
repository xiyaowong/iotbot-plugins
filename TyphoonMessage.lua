-- 台风报文
local Api = require("coreApi")
local http = require("http")

function ReceiveFriendMsg(CurrentQQ, data) return 1 end
function ReceiveEvents(CurrentQQ, data, extData) return 1 end

function ReceiveGroupMsg(CurrentQQ, data)
    if data.FromUserId == tonumber(CurrentQQ) then
        return 1
    end

    if data.Content == '台风报文' then
        local body = http.request('GET', 'http://m.nmc.cn/publish/typhoon/message.html').body
        local msg = body:match([[<p align=left>(.+)<br></p>]]):gsub('<br>', '\n')
        Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TextMsg",
                content = msg,
                groupid = 0,
                atUser = 0,
            }
        )
        return 2
    end
    return 1
end

