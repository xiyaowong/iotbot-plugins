-- FY4A真彩色
local Api = require("coreApi")
local http = require("http")
local json = require("json")

function ReceiveFriendMsg(CurrentQQ, data) return 1 end
function ReceiveEvents(CurrentQQ, data, extData) return 1 end

function ReceiveGroupMsg(CurrentQQ, data)
    if data.FromUserId == tonumber(CurrentQQ) then
        return 1
    end

    if data.Content:find('真彩色') then
        local body = http.request('GET', 'http://www.nmc.cn/rest/relevant/432').body
        local info = json.decode(body)
        Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "PicMsg",
                content = '',
                groupid = 0,
                atUser = 0,
                picUrl = "http://image.nmc.cn"..info[1].image,
                picBase64Buf = "",
                fileMd5 = ""
            }
        )
    end
    return 1
end

