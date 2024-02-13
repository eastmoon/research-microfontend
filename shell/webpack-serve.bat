@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    docker rm -f webpack-%PROJECT_NAME%-dev
    docker run -ti --rm ^
        -v %CLI_DIRECTORY%\app\webpack:/repo ^
        -v %CLI_DIRECTORY%\cache\webpack\node_modules:/repo/node_modules ^
        -v %CLI_DIRECTORY%\cache\webpack\dist:/repo/dist ^
        -w /repo ^
        -p 8082:8082 ^
        --name webpack-%PROJECT_NAME%-dev ^
        node:18 npm run serve
    goto end

:args
    goto end

:short
    echo Startup Webpack develop server
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Startup Webpack develop server
    echo.
    echo Options:
    echo      --help, -h        Show more information with command.
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
