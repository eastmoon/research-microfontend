@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    if defined PROJ (
        @rem create cache directory
        if not exist %CLI_DIRECTORY%\cache\webpack-multi\%PROJ% (
            mkdir %CLI_DIRECTORY%\cache\webpack-multi\%PROJ%
        )

        @rem execute action
        docker run -ti --rm ^
            -v %CLI_DIRECTORY%\app\webpack-multi\%PROJ%:/repo ^
            -v %CLI_DIRECTORY%\cache\webpack-multi\%PROJ%\node_modules:/repo/node_modules ^
            -v %CLI_DIRECTORY%\cache\webpack-multi\%PROJ%\dist:/repo/dist ^
            -w /repo ^
            --name webpack-multi-%PROJECT_NAME%-dev-%RANDOM% ^
            node:18 bash -l -c "npm install && npm run build"
    ) else (
        echo ^> Choose project to build
        goto help
    )

    goto end

:args
    set KEY=%1
    set VALUE=%2
    if "%KEY%"=="--com1" (set PROJ=com-1)
    if "%KEY%"=="--com2" (set PROJ=com-2)
    if "%KEY%"=="--home" (set PROJ=home)
    goto end

:short
    echo Build Webpack project
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Build Webpack project
    echo.
    echo Options:
    echo      --help, -h        Show more information with command.
    echo      --home            Build home proejct.
    echo      --com1            Build com-1 proejct.
    echo      --com2            Build com-2 proejct.
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
