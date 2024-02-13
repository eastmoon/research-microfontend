@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    echo ^> Choose project to build
    goto help

    goto end

:args
    goto end

:short
    echo Build frontend project
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Build frontend project
    echo.
    echo Options:
    echo      --help, -h        Show more information with command.
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
