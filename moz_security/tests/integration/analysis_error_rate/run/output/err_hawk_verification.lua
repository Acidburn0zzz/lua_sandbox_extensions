-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

--[[
# Validate output of moz_security_http_error_rate, iprepd output
--]]

require "string"

local violations = "[{\"violation\":\"fxa:client_error_rate\",\"ip\":\"10.0.2.10\"}," ..
    "{\"violation\":\"fxa:client_error_rate\",\"ip\":\"10.0.2.12\"}]"

local cnt = 0

function process_message()
    local v = read_message("Fields[violations]") or error("message missing violations field")
    if v ~= violations then
        error("message violation value did not match")
    end
    cnt = 1
    return 0
end

function timer_event()
    assert(cnt == 1, string.format("%d out of 1 tests ran", cnt))
end
