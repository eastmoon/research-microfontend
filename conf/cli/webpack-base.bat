@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    docker rm -f webpack-%PROJECT_NAME%-demo
    docker run -d ^
        -v %CLI_DIRECTORY%\cache\webpack\dist:/usr/share/nginx/html ^
        -p 8082:80 ^
        --name webpack-%PROJECT_NAME%-demo ^
        nginx
    goto end

:args
    goto end

:short
    echo Startup Webpack demo server
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Startup Webpack demo server
    echo.
    echo Options:
    echo      --help, -h        Show more information with command.
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
