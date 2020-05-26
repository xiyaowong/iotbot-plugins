-- 历史上的今天
local Api = require("coreApi")
local json = require("json")
local http = require("http")


function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end

function ReceiveGroupMsg(CurrentQQ, data)
    if data.FromUserId == tonumber(CurrentQQ) then
        return 1
    end
    if string.find(data.Content, "历史上的今天") then
        rep, _ = http.request(
            "GET",
            "http://127.0.0.1:8080/today_in_history/"
        )
        Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TextMsg",
                groupid = 0,
                content = '\n'..rep.body,
                atUser = data.FromUserId
            }
        )
        return 2
    end
    return 1
end

function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end
