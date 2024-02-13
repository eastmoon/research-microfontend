@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------
if not defined VARNUMBER1 ( set VARNUMBER1=0 )

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    for /f "tokens=1" %%p in ('docker ps -q -f="name=webcom-%PROJECT_NAME%-demo"') do ( set CONTAINER_ID=%%p )
    if defined CONTAINER_ID (
        docker rm -f %CONTAINER_ID%
    ) else (
        echo Docker container not find.
    )
    goto end

:args
    goto end

:short
    echo Remove Web component demo server
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Remove Web component demo server
    echo.
    echo Options:
    echo      --help, -h        Show more information with command.
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
