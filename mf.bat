@rem
@rem Copyright 2020 the original author jacky.eastmoon
@rem All commad module need 3 method :
@rem [command]        : Command script
@rem [command]-args   : Command script options setting function
@rem [command]-help   : Command description
@rem Basically, CLI will not use "--options" to execute function, "--help, -h" is an exception.
@rem But, if need exception, it will need to thinking is common or individual, and need to change BREADCRUMB variable in [command]-args function.
@rem NOTE, batch call [command]-args it could call correct one or call [command] and "-args" is parameter.
@rem

@rem ------------------- batch setting -------------------
@rem setting batch file
@rem ref : https://www.tutorialspoint.com/batch_script/batch_script_if_else_statement.htm
@rem ref : https://poychang.github.io/note-batch/

@echo off
setlocal
setlocal enabledelayedexpansion

@rem ------------------- declare CLI file variable -------------------
@rem retrieve project name
@rem Ref : https://www.robvanderwoude.com/ntfor.php
@rem Directory = %~dp0
@rem Object Name With Quotations=%0
@rem Object Name Without Quotes=%~0
@rem Bat File Drive = %~d0
@rem Full File Name = %~n0%~x0
@rem File Name Without Extension = %~n0
@rem File Extension = %~x0

set CLI_DIRECTORY=%~dp0
set CLI_FILE=%~n0%~x0
set CLI_FILENAME=%~n0
set CLI_FILEEXTENSION=%~x0
set CLI_SHELL_DIRECTORY=%CLI_DIRECTORY%conf\cli

@rem ------------------- declare CLI variable -------------------

set BREADCRUMB=cli
set COMMAND=
set COMMAND_BC_AGRS=
set COMMAND_AC_AGRS=
set SHELL_FILE=
set SHOW_HELP=

@rem ------------------- declare variable -------------------

for %%a in ("%cd%") do (
    set PROJECT_NAME=%%~na
)

@rem ------------------- execute script -------------------

call :ini-parser
call :main %*
goto end

@rem ------------------- declare function -------------------

@rem Command-line-interface main entrypoint.
:main
    @rem clear variable
    set COMMAND=
    set COMMAND_BC_AGRS=
    set COMMAND_AC_AGRS=
    set SHELL_FILENAME=

    @rem Parse assign variable which input into main function
    @rem It will parse input assign variable and stop at first command ( COMMAND ), and re-group two list variable, option list before command ( COMMAND_BC_AGRS ), option list after command ( COMMAND_AC_AGRS ).
    call :argv-parser %*

    @rem Run main function option, which option control come from "option list before command" ( COMMAND_BC_AGRS ).
    call :main-args %COMMAND_BC_AGRS%

    @rem Execute command
    IF defined COMMAND (
        @rem If exist command, then re-group breadcrumb that is a string struct by command.
        set BREADCRUMB=%BREADCRUMB%-%COMMAND%

        @rem Retrieve next shell filename.
        for /f "tokens=1,* delims=-" %%p in ("!BREADCRUMB!") do ( set SHELL_FILENAME=%%q )

        @rem And if exist a shell file has a name same with breadcrumb, then it is a target file we need to run.
        dir %CLI_SHELL_DIRECTORY%\!SHELL_FILENAME: =!.bat /b >nul 2>&1
        if errorlevel 1 (
            @rem If not exist next shell file, then show help content which in cli file or current shell file
            if defined SHELL_FILE ( call %SHELL_FILE% help ) else ( call :%BREADCRUMB%-help )
        ) else (
            @rem Generate shell file full path.
            set SHELL_FILE=%CLI_SHELL_DIRECTORY%\!SHELL_FILENAME: =!.bat

            @rem Run main function attribute option, which option control come from shell file attribute ( ::@ATTRIBUTE=VALUE ).
            call :main-attr

            @rem If attribute ( stop-cli-parser ) not exist, then run main function with "option list after command" ( COMMAND_AC_AGRS ).
            @rem Main function will run at nested structure, it will search full command breadcrumb come from use input assign variable.
            @rem
            @rem If attribute ( stop-cli-parser ) exist, it mean stop search full command breadcrumb,
            @rem and execute current shell file, and "option list after command" ( COMMAND_AC_AGRS ) become shell file assign variable .
            if not defined ATTR_STOP_CLI_PARSER (
                call :main %COMMAND_AC_AGRS%
            ) else (
                @rem setting command and clear command variable
                set FULL_COMMAND=%COMMAND_AC_AGRS%
                set COMMAND=
                set COMMAND_BC_AGRS=
                set COMMAND_AC_AGRS=

                @rem make sure FULL_COMMAND not exist --help before assign command string
                @rem e.g '--help 1234' it will call command help
                @rem e.g '1234 --help' it will call command and pass FULL_COMMAND string
                call :argv-parser !FULL_COMMAND!
                call :main-args !COMMAND_BC_AGRS!
                call :main-exec !FULL_COMMAND!
            )
        )
    ) else (
        @rem If not exist command, it mean current main function input assign variable only have option, current breadcrumb variable was struct by full command,
        @rem then execute function ( in cli or shell file ) with breadcrumb variable.
        call :main-exec
    )
    goto end

@rem Main function, args running function.
:main-args
    @rem Use recursion to parser each option.
    for /f "tokens=1*" %%p in ("%*") do (
        for /f "tokens=1,2 delims==" %%i in ("%%p") do (
            if defined SHELL_FILE ( call %SHELL_FILE% args %%i %%j ) else ( call :%BREADCRUMB%-args %%i %%j )
            call :common-args %%i %%j
        )
        call :main-args %%q
    )
    goto end

@rem Main function, attribute running function.
:main-attr
    for /f "tokens=1" %%p in ('findstr /bi /c:"::@" %SHELL_FILE%') do (
        for /f "tokens=1,2 delims==" %%i in ("%%p") do (
            set ATT_NAME=%%i
            set ATT_VALUE=%%j
            call :common-attr !ATT_NAME:::@=! !ATT_VALUE!
        )
    )
    goto end

@ Main function, target function execute.
:main-exec
    if defined SHELL_FILE (
        if defined SHOW_HELP ( call %SHELL_FILE% help ) else ( call %SHELL_FILE% action %* )
    ) else (
        if defined SHOW_HELP ( call :%BREADCRUMB%-help ) else ( call :%BREADCRUMB% )
    )
    goto end

@rem Parse args variable
@rem it will search input assign variable, then find first command ( COMMAND ), option list before command ( COMMAND_BC_AGRS ), and option list after command ( COMMAND_AC_AGRS ).
:argv-parser
    @rem Use recursion to find command and args.
    for /f "tokens=1*" %%p in ("%*") do (
        IF NOT defined COMMAND (
            echo %%p | findstr /r "\-" >nul 2>&1
            if errorlevel 1 (
                set COMMAND=%%p
            ) else (
                set COMMAND_BC_AGRS=!COMMAND_BC_AGRS! %%p
            )
        ) else (
            set COMMAND_AC_AGRS=!COMMAND_AC_AGRS! %%p
        )
        call :argv-parser %%q
    )
    goto end

@rem Parse mcli.ini configuration file
:ini-parser
    if exist mcli.ini (
        for /f "usebackq delims=" %%a in ("mcli.ini") do (
            set ln=%%a
            if not "x!ln:~0,1!"=="x[" (
                for /f "tokens=1,2 delims==" %%b in ("!ln!") do (
                    call :common-ini %%b %%c
                )
            )
        )
    )
    goto end

@rem ------------------- command-line-interface common args and attribute method -------------------

@rem Common - ini configuration process
:common-ini
    set KEY=%1
    set VALUE=%2
    if "%KEY%"=="SHELL_DIR" (set CLI_SHELL_DIRECTORY=%CLI_DIRECTORY%%VALUE:/=\%)
    echo %CLI_SHELL_DIRECTORY%

@rem Common - args process
:common-args
    set KEY=%1
    set VALUE=%2
    if "%KEY%"=="-h" (set SHOW_HELP=1)
    if "%KEY%"=="--help" (set SHOW_HELP=1)
    goto end

@rem Common - attribute process
:common-attr
    set KEY=%1
    set VALUE=%2
    if "%KEY%"=="STOP-CLI-PARSER" (set ATTR_STOP_CLI_PARSER=1)
    goto end

@rem ------------------- Main method -------------------

:cli
    goto cli-help
    goto end

:cli-args
    set COMMON_ARGS_KEY=%1
    set COMMON_ARGS_VALUE=%2
    goto end

:cli-help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo If not input any command, at default will show HELP
    echo.
    echo Options:
    echo      --help, -h        Show more information with CLI.
    echo      --prod            Setting project environment with "prod", default is "dev"
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description
    goto end

@rem ------------------- Common Command method -------------------

@rem ------------------- End method-------------------

:end
    endlocal
