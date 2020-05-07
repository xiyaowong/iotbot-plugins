local log = require("log")
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
    if string.find(data.Content, ".short") then
        local longURL = string.gsub(data.Content, ".short", ""):match("^[%s]*(.-)[%s]*$")

        if  string.find(longURL, "http") then --简单校验，越完备能避免请求已知的错误链接浪费资源
            QQString = tostring(CurrentQQ)
            skey = Api.Api_GetUserCook(CurrentQQ).Skey
            uin = "o"..string.rep("0", 10 - #QQString)..QQString

            response, _ = http.request(
                "GET",
                "http://openmobile.qq.com/api/shortUrl",
                {
                    query = string.format('value=["%s"]', longURL), --支持批量生成，简单修改即可
                    headers = {
                        Accept = "application/json",
                        referer= "http://openmobile.qq.com",
                        Cookie= string.format("skey=%s;uin=%s", skey, uin),
                    }
                }
            )
            local html = response.body
            local result = json.decode(html)

            retcode = result.retcode
            if retcode == 0 then
                shortURL = result.result.list[1]
            elseif retcode == 30003 then
                shortURL = "链接转换失败，请检查链接有效性!"
            else
                shortURL = "转换失败!"
                log.error("短链转换失败: %s", longURL.." => "..result.msg)
            end

        else
            shortURL = "链接格式错误，需要包含http"
        end

        Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TextMsg",
                groupid = 0,
                content = shortURL,
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
