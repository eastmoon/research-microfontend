@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    @rem declare variable
    set PROJ=angular-app

    @rem build image
    cd %CLI_DIRECTORY%/conf/docker
    docker build -t angular.dev:%PROJECT_NAME% -f Dockerfile.angular .
    cd %CLI_DIRECTORY%

    @rem create cache directory
    if not exist %CLI_DIRECTORY%\cache\mff\%PROJ% (
        mkdir %CLI_DIRECTORY%\cache\mff\%PROJ%
    )

    @rem start project
    docker rm -f mff-%PROJECT_NAME%-dev-ng
    docker run -ti --rm ^
        -v %CLI_DIRECTORY%\app\mff\%PROJ%:/repo ^
        -v %CLI_DIRECTORY%\cache\mff\%PROJ%\node_modules:/repo/node_modules ^
        -v %CLI_DIRECTORY%\cache\mff\%PROJ%\dist:/repo/dist ^
        -w /repo ^
        --name mff-%PROJECT_NAME%-dev-ng ^
        angular.dev:%PROJECT_NAME% bash
    goto end

:args
    goto end

:short
    echo Startup angular develop tools
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Startup angular develop tools
    echo.
    echo Options:
    echo      --help, -h        Show more information with command.
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
