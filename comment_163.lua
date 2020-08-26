-- 网易云热评
local Api = require("coreApi")
local http = require("http")
local json = require("json")

function ReceiveFriendMsg(CurrentQQ, data) return 1 end
function ReceiveEvents(CurrentQQ, data, extData) return 1 end

function ReceiveGroupMsg(CurrentQQ, data)
    if data.FromUserId == tonumber(CurrentQQ) then
        return 1
    end
    if data.Content:find('网易云热评') then
        local body = http.request('GET', 'https://www.mouse123.cn/api/163/api.php').body
        local info = json.decode(body)
        local comment = string.format(
            '歌曲: %s\n歌手: %s\n评论: %s',
            info.title, info.author, info.comment_content
        )
        Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "PicMsg",
                content = comment,
                groupid = 0,
                atUser = 0,
                picUrl = info.images,
                picBase64Buf = "",
                fileMd5 = ""
            }
        )
    end
    return 1
end
