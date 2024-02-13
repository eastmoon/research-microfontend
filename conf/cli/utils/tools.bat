@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:command-description
    set TARGET_FILE_PATTERN="^[a-z]*\.bat"
    set COMMAND_DESC_P1=%1
    if defined COMMAND_DESC_P1 ( set TARGET_FILE_PATTERN="^%COMMAND_DESC_P1%-[a-z]*\.bat" )
    dir %CLI_SHELL_DIRECTORY% /b | findstr %TARGET_FILE_PATTERN% >nul 2>&1
    if errorlevel 1 (
        echo.
    ) else (
        echo.
        echo Command:
        for /f "tokens=*" %%p in ('dir %CLI_SHELL_DIRECTORY% /b ^| findstr %TARGET_FILE_PATTERN%') do (
            set COMMAND_DESC_NAME=%%~np
            set CDNT=!COMMAND_DESC_NAME:-= !
            for %%a in (!CDNT!) do ( set COMMAND_DESC_NAME=%%a )
            for /f "tokens=*" %%f in ('%CLI_SHELL_DIRECTORY%\%%p short') DO ( SET COMMAND_DESCSHORT=%%f )
            echo      !COMMAND_DESC_NAME!           !COMMAND_DESCSHORT!
        )
        echo.
        echo Run '%CLI_FILENAME% [COMMAND] --help' for more information on a command.
    )
    goto end

@rem ------------------- End method-------------------

:end
