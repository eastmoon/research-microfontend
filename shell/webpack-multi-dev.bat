@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    docker rm -f webpack-multi-%PROJECT_NAME%-dev
    docker run -ti ^
        -v %CLI_DIRECTORY%\app\webpack-multiple:/repo ^
        -w /repo ^
        --name webpack-multi-%PROJECT_NAME%-dev ^
        node:18 bash
    goto end

:args
    goto end

:short
    echo Startup node.js develop server
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Startup node.js develop server
    echo.
    echo Options:
    echo      --help, -h        Show more information with command.
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
