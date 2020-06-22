import java.io.File
timer = 0
playername = player.getName().toString()

IF $isop
datefile = File("./plugins/TriggerReactor/Placeholder/realdate.js")
IF args.length == 0
	#MESSAGE "올바르지 않는 명령어 입니다. "
	#MESSAGE "/타이머 D H M S 예) /타이머 0D 0H 1M 0S"
	#MESSAGE "/타이머 중단 - 타이머를 중단합니다"
	#MESSAGE "/타이머 제거 - 타이머스코어보드를 지웁니다"
	#STOP
ELSE
ENDIF

IF args[0] == "중단"
{"Dchitimerstop"} = "true"
#STOP
ELSE
ENDIF

IF args[0] == "제거"
IF {"Dchitimerrun"} == "true"
	#MESSAGE "&4타이머가 흐르는 중에는 타이머 스코어보드를 제거 할 수 없습니다."
	#STOP
ELSE
	#SCOREBOARD "OBJ" "timerD" "SET" {"DchTmsg"} null
	#MESSAGE "타이머를 제거했습니다"
	#STOP
ENDIF
ELSE
ENDIF


IF args.length == 4

    IF args[0].contains("D")
        text = args[0].replace("D", "")
        num = parseInt(text)
        num = num * 86400
        timer = timer + num
        IF args[1].contains("H")
            text = args[1].replace("H", "")
            num = parseInt(text)
            num = num * 3600
            timer = timer + num
            IF args[2].contains("M")
                text = args[2].replace("M", "")
                num = parseInt(text)
                num = num * 60
                timer = timer + num
                IF args[3].contains("S")
                    text = args[3].replace("S", "")
                    num = parseInt(text)
                    timer = timer + num
                    IF {"Dchitimerrun"} != "true"
					{"Dchitimerrun"} = "true"
                    timerr = 0
						{"Dtimere1"} = timer / 10
                        {"Dtimere3"} = {"Dtimere1"} * 3
                        {"Dtimere5"} = {"Dtimere1"} * 5
					    #SCOREBOARD "OBJ" "timerD" "SLOT" "SIDEBAR"
						{"Dchitimerstop"} = "false"
						name = "&b&l타이머"
                        name = name.replace("&", "§")
                        #SCOREBOARD "OBJ" "timerD" "NAME" name
                    FOR timerr = 0:timer+1
						IF {"Dchitimerstop"} == "true"
						IF {"DchTmsg"} == "null"
						ELSE
							name = "&b&l타이머 &6&l- 중단됨"
							name = name.replace("&", "§")
							#SCOREBOARD "OBJ" "timerD" "SET" {"DchTmsg"} null
							#SCOREBOARD "OBJ" "timerD" "NAME" name
							msg = {"DchTmsg"}
							char = msg.charAt(1).toString()
							msg = msg.replace(char, "6")
							msg = msg.replace("남은 시간 : ", "")
							#SCOREBOARD "OBJ" "timerD" "SET" msg 1
							{"DchTmsg"} = msg
							#BROADCAST "타이머가 관리자 "+playername+"에 의하여 중단되었습니다."
							{"Dchitimerrun"} = "stop"
							#STOP
						ENDIF
						ELSE
						ENDIF
                        D = timer / 86400
                        Dd = timer % 86400
                        H = Dd / 3600
                        Hh = Dd % 3600
                        M = Hh / 60
                        Mm = Hh % 60
                        S = Mm
                        msg = "&a&l남은 시간 : " + D + "일 " + H + "시간 " + M + "분 " + S + "초"    
                        IF timer > {"Dtimere5"}
						IF {"DchTmsg"} == "null"
						ELSE
                            #SCOREBOARD "OBJ" "timerD" "SET" {"DchTmsg"} null
						ENDIF
                            msg = msg.replace("&", "§")
                            #SCOREBOARD "OBJ" "timerD" "SET" msg 1
                            {"DchTmsg"} = msg
                        ELSE                        
                            msg = msg.replace("&a", "&e")
                            msg = msg.replace("&", "§")
							#SCOREBOARD "OBJ" "timerD" "SET" {"DchTmsg"} null
                            #SCOREBOARD "OBJ" "timerD" "SET" msg 1
                            {"DchTmsg"} = msg
                            IF timer < {"Dtimere1"}
							#SCOREBOARD "OBJ" "timerD" "SET" {"DchTmsg"} null
                            msg = msg.replace("§e", "§4")
                            #SCOREBOARD "OBJ" "timerD" "SET" msg 1
                            {"DchTmsg"} = msg
                            ELSE
                            ENDIF
                        ENDIF
                        IF timer == 0
							name = "&b&l타이머 &6&l- 만료됨"
							name = name.replace("&", "§")
							#SCOREBOARD "OBJ" "timerD" "NAME" name
							IF datefile.exists()
							#BROADCAST	$realdate+"&6&l타이머의 시간이 모두 지났습니다"
							#ACTIONBAR $realdate+"§6§l타이머의 시간이 모두 지났습니다"
							ELSE
							#BROADCAST	"&6&l타이머의 시간이 모두 지났습니다"
							#ACTIONBAR "§6§l타이머의 시간이 모두 지났습니다"							
							ENDIF
							{"Dchitimerrun"} = "stop"
							#STOP
                        ELSE
						#WAIT 1
						timer = timer - 1	
                        ENDIF
                        ENDFOR
                    ELSE
                        #MESSAGE "타이머가 이미 동작중입니다."
                    ENDIF
                        
                ELSE
                ENDIF
            ELSE 
            ENDIF
        ELSE
        ENDIF    
    ELSE
    ENDIF

ELSE
	#MESSAGE "올바르지 않는 명령어 입니다. /타이머 D H M S 예) /타이머 0D 0H 1M 0S"
ENDIF

ELSE
	#MESSAGE "&4이 명령어를 사용할수 있는 권한이 없습니다."
ENDIF