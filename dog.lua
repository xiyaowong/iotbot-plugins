-- dog => 舔狗日记
local Api = require("coreApi")
local http = require("http")

function ReceiveFriendMsg(CurrentQQ, data) return 1 end
function ReceiveEvents(CurrentQQ, data, extData) return 1 end

local urls = {
    "http://www.vizy8.cn/api2/tgrj/api.php",
    "http://test.isiyuan.net/tiangou/tg.php"
}

function ReceiveGroupMsg(CurrentQQ, data)
    if data.FromUserId == tonumber(CurrentQQ) then
        return 1
    end
    if string.find(data.Content, 'dog') then
        math.randomseed(os.time())
        Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TextMsg",
                groupid = 0,
                content = '\n'..http.request('GET', urls[math.random(1,#urls)]).body,
                atUser = data.FromUserId
            }
        )
    end
    return 1
end
