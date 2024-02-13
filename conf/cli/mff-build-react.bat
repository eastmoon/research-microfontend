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
    docker run -ti --rm ^
        -v %CLI_DIRECTORY%\app\mff\%PROJ%:/repo ^
        -v %CLI_DIRECTORY%\cache\mff\%PROJ%\node_modules:/repo/node_modules ^
        -v %CLI_DIRECTORY%\cache\mff\%PROJ%\dist:/repo/build ^
        -w /repo ^
        --name multi-%PROJECT_NAME%-dev-%RANDOM% ^
        node:18 bash -l -c "npm install && npm run build"

    goto end

:args
    goto end

:short
    echo Build react project
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Build react project
    echo.
    echo Options:
    echo      --help, -h        Show more information with command.
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
