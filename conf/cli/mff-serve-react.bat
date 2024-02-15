@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    @rem declare variable
    set PROJ=react-app

    @rem create cache directory
    if not exist %CLI_DIRECTORY%\cache\mff\%PROJ% (
        mkdir %CLI_DIRECTORY%\cache\mff\%PROJ%
    )

    @rem execute action
    docker rm multi-%PROJECT_NAME%-dev-react
    docker run -ti --rm ^
        -v %CLI_DIRECTORY%\app\mff\%PROJ%:/repo ^
        -v %CLI_DIRECTORY%\cache\mff\%PROJ%\node_modules:/repo/node_modules ^
        -v %CLI_DIRECTORY%\cache\mff\%PROJ%\dist:/repo/dist ^
        -p 8084:8084 ^
        -w /repo ^
        --name multi-%PROJECT_NAME%-dev-react ^
        node:18 bash -l -c "npm install && npm run start"

    goto end

:args
    goto end

:short
    echo Startup react develop server
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Startup react develop server
    echo.
    echo Options:
    echo      --help, -h        Show more information with command.
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
