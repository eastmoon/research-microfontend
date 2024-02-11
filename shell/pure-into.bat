@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------
if not defined VARNUMBER1 ( set VARNUMBER1=0 )

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    docker exec -ti ^
        pure-%PROJECT_NAME%-demo bash
    goto end

:args
    goto end

:short
    echo Into JavaScript demo server
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Into JavaScript demo server
    echo.
    echo Options:
    echo      --help, -h        Show more information with command.
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
