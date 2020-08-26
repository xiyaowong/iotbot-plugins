-- verse/古诗/诗句
local Api = require("coreApi")
local http = require("http")
local json = require("json")

function ReceiveFriendMsg(CurrentQQ, data) return 1 end
function ReceiveEvents(CurrentQQ, data, extData) return 1 end

function ReceiveGroupMsg(CurrentQQ, data)
    if data.FromUserId == tonumber(CurrentQQ) then
        return 1
    end
    if data.Content:find('古诗') or data.Content:find('诗句') then
        local body = http.request('GET', 'https://v1.jinrishici.com/all.json').body
        local info = json.decode(body)
        local verse = string.format(
            '【%s】 写的 【%s】\n------\n%s',
            info.author, info.origin, info.content
        )
        Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TextMsg",
                groupid = 0,
                content = verse,
                atUser = 0
            }
        )
    end
    return 1
end
