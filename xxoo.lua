local log = require("log")
local api = require("coreApi")
local json = require("json")
local http = require("http")

function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end

function ReceiveGroupMsg(CurrentQQ, data)
    if data.FromGroupId ~= 818316898 and data.FromUserId == 286183317 then
        if data.Content == 'xxoo' then
            rep, _ = http.request(
                'GET',
                'https://cdn.jsdelivr.net/gh/XiyaoWong/xxoo/data.json'
            )
            local pics = json.decode(rep.body).pics

            math.randomseed(os.time())
            local pic = 'https://cdn.jsdelivr.net/gh/XiyaoWong/xxoo/pics/'..pics[math.random(1, #pics)]

            api.Api_SendMsg(
               CurrentQQ,
                {
                  toUser = data.FromGroupId,
                  sendToType = 2,
                  sendMsgType = "PicMsg",
                  content = "",
                  groupid = 0,
                  atUser = 0,
                  picUrl = pic,
                  picBase64Buf = "",
                  fileMd5 = "",
                  flashPic = true
                }
           )
        end
    end
    return 1
end

function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end
