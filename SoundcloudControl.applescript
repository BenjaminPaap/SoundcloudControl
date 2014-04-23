on alfred_script(q)
    tell application "Google Chrome"
        repeat with w in every window
            title of w
            repeat with t in every tab of w
                -- Search for a soundcloud.com tab
                if URL of t contains "soundcloud.com" then
                    if q = "play" then
                        -- Play the first song
                        execute t javascript "$('button.playControl').click();"
                    end if
                    if q = "pause" then
                        -- Pause current playback
                        execute t javascript "$('button.playControl.playing').click();"
                    end if
                    if q = "next" then
                        -- Play the next song
                        execute t javascript "$('button.skipControl__next').click();"
                    end if
                    if q = "prev" then
                        -- When the currently playing song ran less than 5 seconds only hit the button once
                        -- If it ran more than 5 seconds we have to hit it twice to get to the previous track
                        set _time to execute t javascript "Number($('div.playbackTitle__progress div[aria-valuenow]').attr('aria-valuenow')).toFixed(0);"
                        set _time to _time as number
                        if _time < 5000 then
                            set _count to 1
                        else
                            set _count to 2
                        end if
                        execute t javascript "for (i = 0; i < " & _count & "; i ++) { $('button.skipControl__previous').click(); }"
                    end if
                    if q = "like" then
                        -- Like the currently playing song
                        set _title to execute t javascript "$('a.playbackTitle__link').text();"
                        execute t javascript "$('div[aria-label*=\"" & _title & "\"] button.sc-button-like').click();"
                    end if
                end if
            end repeat
        end repeat
    end tell
end alfred_script