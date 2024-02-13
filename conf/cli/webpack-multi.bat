@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    docker rm -f webpack-multi-%PROJECT_NAME%-demo
    docker run -d ^
        -v %CLI_DIRECTORY%\cache\webpack-multi\home\dist:/usr/share/nginx/html ^
        -v %CLI_DIRECTORY%\cache\webpack-multi\com-1\dist:/usr/share/nginx/html/js/com-1 ^
        -v %CLI_DIRECTORY%\cache\webpack-multi\com-2\dist:/usr/share/nginx/html/js/com-2 ^
        -p 8083:80 ^
        --name webpack-multi-%PROJECT_NAME%-demo ^
        nginx
    goto end

:args
    goto end

:short
    echo Startup Webpack multi project demo server
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Startup Webpack multi project demo server
    echo.
    echo Options:
    echo      --help, -h        Show more information with command.
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
