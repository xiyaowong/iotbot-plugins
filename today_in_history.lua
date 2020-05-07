local log = require("log") --导入日志输出模块
local Api = require("coreApi")--导入API模块
local json = require("json")--导入JSON解析模块
local http = require("http")--导入HTTP模块


function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end

function ReceiveGroupMsg(CurrentQQ, data)
    if data.FromUserId == tonumber(CurrentQQ) then
        return 1
    end
    if data.Content == ".lssdjt" then
        response, _ = http.request(
            "GET",
            "http://116.62.167.164:8080/today_in_history/"
        )
        html = response.body
        if not html then
            html = "小生不才，不知为何，啥也没有..."
        end
        html = string.sub(html, 1, 2450)
        Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TextMsg",
                groupid = 0,
                content = html,
                atUser = data.FromUserId
            }
        )
        return 2
    end
    return 1
end
--收到所有相关事件的集合 如群成员进群退群管理升降消息撤回、好友撤回删除等事件
function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end
