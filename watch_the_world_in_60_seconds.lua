-- 60s看世界 `看世界`
local Api = require("coreApi")

function ReceiveGroupMsg(CurrentQQ, data) 
    if data.FromUserId == tonumber(CurrentQQ) then
        return 1
    end
    if data.Content == '看世界' then
        Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "PicMsg",
                picUrl = 'http://yanxi520.xyz/api/60s/min.php?address=1&name='..data.FromNickName,
            }
        )
    end
    return 1 
end

function ReceiveFriendMsg(CurrentQQ, data) return 1 end
function ReceiveEvents(CurrentQQ, data, extData) return 1 end
