@echo off
chcp 65001 >nul
title OpenCreator - Run UI
cd /d "%~dp0"

echo =======================================
echo  OpenCreator - Khoi dong UI
echo =======================================
echo Thu muc: %CD%
echo.

where node >nul 2>nul
if %errorlevel% neq 0 (
  echo [LOI] Chua cai Node.js!
  pause
  exit /b 1
)
echo [OK] Node:
call node -v
call npm -v

:: 1. Tu dong cai pnpm neu chua co
where pnpm >nul 2>nul
if %errorlevel% neq 0 (
  echo.
  echo [INFO] Chua co pnpm - dang cai dat...
  call corepack enable
  call corepack prepare pnpm@latest --activate
  where pnpm >nul 2>nul
  if %errorlevel% neq 0 (
    echo [INFO] Thu cai qua npm...
    call npm install -g pnpm
  )
)
echo [OK] pnpm:
call pnpm -v
echo.

:: 2. Chay UI
if exist "apps\web\package.json" (
  echo [INFO] Tim thay apps/web - dang chay...
  cd apps\web
  call pnpm dev
) else (
  echo [INFO] Chay o thu muc goc...
  call pnpm dev
)

pause