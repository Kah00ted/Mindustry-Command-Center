set pathToMe to (POSIX path of (path to me))
set pathToMe to do shell script ("echo '" & pathToMe & "' | sed 's/ /\\\\ /g'")
set myIP to IPv4 address of (get system info)

set mindustryServerPath to "/Volumes/SMALL_BIG/code/Mindustry-CC/mindustry-server/"

on onStartup()
    display dialog "Mindustry Control Center" buttons {"Start Server Terminal", "Exit"}
    if result = {button returned:"Start Server Terminal"} then
        startTerminal()
    end if

end onStartup

on startTerminal()
    global mindustryServerPath

    tell application "Terminal"
        reopen
        activate
        do script ("cd "& mindustryServerPath) in window 1
        do script ("java -jar "& mindustryServerPath &"server.jar") in window 1
    end tell

    display dialog "Server Terminal Started" buttons {"Host New Game", "Load From Save", "Exit"}
    if result = {button returned:"Host New Game"} then
        hostNew()
    else if result = {button returned:"Load From Save"} then
        set saveNum to text returned of (display dialog "Save Number:" default answer "")
        tell application "Terminal"
            activate
            do script ("load " & saveNum) in window 1
        end tell
    end if
end startTerminal

on hostNew()
    set selectMap to text returned of (display dialog "Map" default answer "")
    set selectGamemode to text returned of (display dialog "Gamemode" default answer "")

    tell application "Terminal"
        activate
        do script ("host "&selectMap&" "&selectGamemode) in window 1
    end tell
end hostNew

onStartup()