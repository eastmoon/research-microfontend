@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    docker rm -f mff-%PROJECT_NAME%-demo
    docker run -d ^
        -v %CLI_DIRECTORY%\cache\mff\home\dist:/usr/share/nginx/html ^
        -v %CLI_DIRECTORY%\cache\mff\react-app\dist:/usr/share/nginx/html/assets/react-app ^
        -v %CLI_DIRECTORY%\cache\mff\react-app\dist\static\media:/usr/share/nginx/html/static/media ^
        -v %CLI_DIRECTORY%\cache\mff\vue-app\dist:/usr/share/nginx/html/assets/vue-app ^
        -v %CLI_DIRECTORY%\cache\mff\angular-app\dist\browser:/usr/share/nginx/html/assets/angular-app ^
        -p 8084:80 ^
        --name mff-%PROJECT_NAME%-demo ^
        nginx
    goto end

:args
    goto end

:short
    echo Startup multi frontend framework demo server
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Startup multi frontend framework demo server
    echo.
    echo Options:
    echo      --help, -h        Show more information with command.
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
