@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    echo ^> Choose project to startup develop server
    goto help

    goto end

:args
    goto end

:short
    echo Startup frontend project develop server
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Startup frontend project develop server
    echo.
    echo Options:
    echo      --help, -h        Show more information with command.
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
