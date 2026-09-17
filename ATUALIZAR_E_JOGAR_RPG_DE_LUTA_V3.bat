@echo off
setlocal EnableExtensions EnableDelayedExpansion
title RPG-DE-LUTA - Atualizar e Jogar
color 0A

set "REPO_URL=https://github.com/MateusSValente/RPG-DE-LUTA.git"
set "ROOT=C:\Projetos"
set "PROJECT=%ROOT%\RPG-DE-LUTA"
set "GODOT="

echo ============================================================
echo         RPG-DE-LUTA - ATUALIZAR E JOGAR V3
echo ============================================================
echo.

if not exist "%ROOT%" mkdir "%ROOT%"

echo [1/4] Verificando Git...
where git.exe >nul 2>&1
if errorlevel 1 (
    echo ERRO: Git nao encontrado.
    start "" "https://git-scm.com/download/win"
    pause
    exit /b 1
)

echo [2/4] Baixando/atualizando projeto...
if exist "%PROJECT%\.git" (
    pushd "%PROJECT%"
    git fetch origin
    if errorlevel 1 goto :git_error
    git checkout main
    if errorlevel 1 goto :git_error
    git pull --ff-only origin main
    if errorlevel 1 goto :git_error
    popd
) else (
    if exist "%PROJECT%" (
        echo ERRO: "%PROJECT%" existe mas nao e repositorio Git.
        pause
        exit /b 1
    )
    git clone "%REPO_URL%" "%PROJECT%"
    if errorlevel 1 goto :git_error
)

if not exist "%PROJECT%\project.godot" (
    echo ERRO: project.godot nao encontrado.
    pause
    exit /b 1
)

echo [3/4] Procurando Godot 4.7.2 / Godot 4...

for %%N in (godot4.exe godot.exe Godot_v4.7.2-stable_win64.exe) do (
    if not defined GODOT (
        for /f "delims=" %%P in ('where %%N 2^>nul') do (
            if exist "%%P" set "GODOT=%%P"
        )
    )
)

if not defined GODOT if exist "C:\Godot\Godot_v4.7.2-stable_win64.exe" set "GODOT=C:\Godot\Godot_v4.7.2-stable_win64.exe"
if not defined GODOT if exist "C:\Godot\Godot.exe" set "GODOT=C:\Godot\Godot.exe"
if not defined GODOT if exist "C:\Program Files\Godot\Godot.exe" set "GODOT=C:\Program Files\Godot\Godot.exe"
if not defined GODOT if exist "%LOCALAPPDATA%\Programs\Godot\Godot.exe" set "GODOT=%LOCALAPPDATA%\Programs\Godot\Godot.exe"

if not defined GODOT if exist "%USERPROFILE%\Downloads" (
    for /r "%USERPROFILE%\Downloads" %%G in (Godot*.exe) do (
        if not defined GODOT (
            echo %%~nxG | findstr /I /V "console" >nul
            if not errorlevel 1 if exist "%%~fG" set "GODOT=%%~fG"
        )
    )
)

if not defined GODOT if exist "%USERPROFILE%\Desktop" (
    for /r "%USERPROFILE%\Desktop" %%G in (Godot*.exe) do (
        if not defined GODOT (
            echo %%~nxG | findstr /I /V "console" >nul
            if not errorlevel 1 if exist "%%~fG" set "GODOT=%%~fG"
        )
    )
)

if not defined GODOT (
    echo.
    echo ERRO: Godot 4 nao encontrado.
    echo Extraia o Godot 4.7.2 em C:\Godot ou deixe o EXE em Downloads.
    start "" "https://godotengine.org/download/windows/"
    pause
    exit /b 2
)

echo Godot encontrado:
echo "%GODOT%"
echo.

echo [4/4] Abrindo o jogo...
echo.
echo CONTROLES
echo A / D = mover
echo J     = combo fraco
echo K     = combo forte
echo L     = defesa
echo R     = restaurar boneco
echo.

start "" "%GODOT%" --path "%PROJECT%"

exit /b 0

:git_error
popd >nul 2>&1
echo.
echo ERRO AO ATUALIZAR O GIT.
echo Verifique a internet e execute novamente.
pause
exit /b 1
