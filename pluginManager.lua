local log = require("log")
local Api = require("coreApi")
local json = require("json")
local http = require("http")

function ReceiveFriendMsg(CurrentQQ, data)
    log.notice("From stop.lua  ReceiveFriendMsg %s", CurrentQQ)
    return 1
end
function ReceiveGroupMsg(CurrentQQ, data)
    if CurrentQQ ~= "192801941" then --响应消息的QQ机器人
        return 1
    end
    if data.FromUserId == 192801941 then --不处理机器人自己发出来的消息
        return 1
    end
    if string.find(data.Content, "停用") then --指令
        file = data.Content:gsub("停用", "")
        local ts = io.popen("ls ./Plugins/")
        local ls = ts:read("*all")
        --[[(sys%a+)]]
        file = ls:match(string.format("(%s%s", file, "%a+)"))
        if file == nil then
            --匹配失败
            return 1
        end
        log.info("=====%s", file)
        filePath = string.format("./Plugins/%s.lua", file)
        newPath = string.format("./Plugins/%s.bak", file)
        if os.rename(filePath, newPath) then
            Api.Api_SendMsg(
                CurrentQQ,
                {
                    toUser = data.FromGroupId,
                    sendToType = 2,
                    sendMsgType = "TextMsg",
                    groupid = 0,
                    content = file .. "停用成功",
                    atUser = 0
                }
            )
        end
    end
    if string.find(data.Content, "启用") then --指令
        file = data.Content:gsub("启用", "")
        local ts = io.popen("ls ./Plugins/")
        local ls = ts:read("*all")
        --[[(sys%a+)]]
        file = ls:match(string.format("(%s%s", file, "%a+)"))
        if file == nil then
            --匹配失败
            return 1
        end
        filePath = string.format("./Plugins/%s.bak", file)
        newPath = string.format("./Plugins/%s.lua", file)
        if os.rename(filePath, newPath) then
            Api.Api_SendMsg(
                CurrentQQ,
                {
                    toUser = data.FromGroupId,
                    sendToType = 2,
                    sendMsgType = "TextMsg",
                    groupid = 0,
                    content = file .. "启用成功",
                    atUser = 0
                }
            )
        end
    end
    return 1
end
function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end
