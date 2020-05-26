-- 百科
local Api = require("coreApi")
local http = require("http")

function stringStarts(str, Start)
   return string.sub(str, 1, string.len(Start)) == Start
end

function urlEncode(s)
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
    if data.FromUserId ~= tonumber(CurrentQQ) then
        if stringStarts(data.Content, "百科") then
            print('running...baike')
            kw = data.Content:gsub("百科", "")
            rep, _ = http.request(
                "GET",
                "http://127.0.0.1:8080/baidubaike/?kw="..urlEncode(kw)
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

        end
    end
end


