set pathToMe to (POSIX path of (path to me))
set pathToMe to do shell script ("echo '" & pathToMe & "' | sed 's/ /\\\\ /g'")
set myIP to IPv4 address of (get system info)

set mindustryServerPath to "/Volumes/SMALL_BIG/code/Mindustry-CC/mindustry-server/"


display dialog "Mindustry Control Center" buttons {"Start Server Terminal", "Exit"}
if result = {button returned:"Start Server Terminal"} then
    tell application "Terminal"
            reopen
            activate
            do script ("java -jar "& mindustryServerPath &"server.jar") in window 1
    end tell

    display dialog "Server Terminal Started" buttons {"Host New Game", "Load From Save", "Exit"}
    if result = {button returned:"Host New Game"} then
        tell application "Terminal"
            #activate
            do script ("host") in window 1
        end tell
    else if result = {button returned:"Load From Save"} then
        display dialog "Save Number:" default answer ""
        tell application "Terminal"
            #activate
            do script ("load " & (text returned of result)) in window 1
        end tell
    end if

end if