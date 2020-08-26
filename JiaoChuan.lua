-- 娇喘
local Api = require("coreApi")
local http = require("http")


function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end

function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end

local voices = {
    "https://attachments-cdn.shimo.im/WQIWXgk1HknfpagZ.amr",
    "https://attachments-cdn.shimo.im/45uhY63C3plXzv6v.amr",
    "https://attachments-cdn.shimo.im/xdQmiRqFBb9e5KVP.amr",
    "https://attachments-cdn.shimo.im/9S9K3vjSISUycwJB.amr",
    "https://attachments-cdn.shimo.im/91LlpYmitUnYPTnn.amr",
    "https://attachments-cdn.shimo.im/twzrCYlp11MlQzKu.amr",
    "https://attachments-cdn.shimo.im/QTvXoLlicSoqa1I7.amr",
    "https://attachments-cdn.shimo.im/aAX3u7i5nihza02t.amr",
    "https://attachments-cdn.shimo.im/snKhlAt2RPrZZi6T.amr",
    "https://attachments-cdn.shimo.im/u2PoU0IljlVio5cx.amr",
    "https://attachments-cdn.shimo.im/LW4k7vtKzvTZs1Ok.amr",
    "https://attachments-cdn.shimo.im/m9Mnlw2GbC84TxSt.amr",
    "https://attachments-cdn.shimo.im/IA8xKzLgXi5LNzSZ.amr",
    "https://attachments-cdn.shimo.im/WOmD35EIAAGAYhYZ.amr",
    "https://attachments-cdn.shimo.im/6Pq1BQxaE6tysbM0.amr",
    "https://attachments-cdn.shimo.im/fIgUsI2WcEcyzgSJ.amr",
    "https://attachments-cdn.shimo.im/FCCHQTHNnXOIjqZC.amr",
    "https://attachments-cdn.shimo.im/yhJFhI1ZzbmZoMUr.amr",
    "https://attachments-cdn.shimo.im/4q5hMiPBsJPxgtaJ.amr",
    "https://attachments-cdn.shimo.im/qCvlUtH2V7LDiyXI.amr",
    "https://attachments-cdn.shimo.im/egsYT5u33vRvL0Tw.amr",
    "https://attachments-cdn.shimo.im/QCCbTM8YSDbxH1xy.amr",
    "https://attachments-cdn.shimo.im/N4NoxhuKLtMLGzy6.amr",
    "https://attachments-cdn.shimo.im/76Dm2NZNjVxWlbPF.amr",
    "https://attachments-cdn.shimo.im/rj8jlEqmpXQmz6bL/37.amr",
    "https://attachments-cdn.shimo.im/6gHn0pdSYvW7Kmho.amr",
    "https://attachments-cdn.shimo.im/TCq0NaBsAhepMR17.amr",
    "https://attachments-cdn.shimo.im/Pe7BWAAZl2tfXMBu.amr",
    "https://attachments-cdn.shimo.im/87E2svjw7wWUR8iv.amr",
    "https://attachments-cdn.shimo.im/nhuU8dmQGSp1UA9r.amr",
    "https://attachments-cdn.shimo.im/XHYLxbreeNeXJ9kw.amr",
    "https://attachments-cdn.shimo.im/eprH56cpkV2j0bFM.amr",
    "https://attachments-cdn.shimo.im/ER9OqfLs9VtU5Ype.amr",
    "https://attachments-cdn.shimo.im/MN6iuWgJ3Ru7ToBe.amr",
    "https://attachments-cdn.shimo.im/Mfor8kW8RM3ylDfa.amr"
}


function ReceiveGroupMsg(CurrentQQ, data)
    if data.FromUserId == tonumber(CurrentQQ) then
        return 1
    end
    if string.find(data.Content, '色图') then
        math.randomseed(os.time())

        local nums = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}
        if nums[math.random(1, #nums)] == 0 then
            return 1
        end

        local url = voices[math.random(1,#voices)]
        Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "VoiceMsg",
                content = "",
                groupid = 0,
                atUser = 0,
                voiceUrl = url,
                voiceBase64Buf = "",
                atUser = 0
            }
        )

        return 1
    end
    return 1
end
