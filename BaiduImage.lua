-- pic 百度图片
local Api = require("coreApi")
local http = require("http")
local json = require("json")

function sleep(n)
       os.execute("sleep " .. n)
end

function stringStarts(str, Start) --字符串是否以指定字符开头
   return string.sub(str, 1, string.len(Start)) == Start
end

local function urlEncode(s)
  s = string.gsub(s, "([^%w%.%- ])", function(c) return string.format("%%%02X", string.byte(c)) end)
  return string.gsub(s, " ", "%%20")
end

function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end

function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end


function ReceiveGroupMsg(CurrentQQ, data)
    if data.FromUserId == tonumber(CurrentQQ) then
        return 1
    end
    if stringStarts(data.Content, "pic") then
        kw = data.Content:gsub("pic", "")
        rep, _ = http.request(
            "GET",
            "http://127.0.0.1:8080/baidu_image/?&kw="..urlEncode(kw)
        )
        imgs = json.decode(rep.body)
        if #imgs == 0 then
            Api.Api_SendMsg(
                CurrentQQ,
                {
                    toUser = data.FromGroupId,
                    sendToType = 2,
                    sendMsgType = "TextMsg",
                    groupid = 0,
                    content = "小生不才，不知为何，啥也没有...",
                    atUser = data.FromUserId
                }
            )
            return 2
        end
        for _, url in pairs(imgs) do
            Api.Api_SendMsg(
                CurrentQQ,
                {
                    toUser = data.FromGroupId,
                    sendToType = 2,
                    sendMsgType = "PicMsg",
                    groupid = 0,
                    picUrl = url,
                    picBase64Buf = "",
                    content = "",
                    fileMd5 = "",
                    atUser = 0
                }
            )
            sleep(0.5)
        end
        return 2
    end
    return 1
end

