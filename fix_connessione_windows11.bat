@echo off
color 0A
title Fix Connessione Windows 11

echo ================================================
echo     Script di riparazione connessione di rete
echo ================================================
echo.

:: Esegui come amministratore check
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Questo script richiede i privilegi di amministratore.
    echo Chiudi e rilancia lo script cliccando col destro > "Esegui come amministratore".
    pause
    exit /b
)

echo Rilascio indirizzo IP...
ipconfig /release
echo.

echo Rinnovo indirizzo IP...
ipconfig /renew
echo.

echo Pulizia cache DNS...
ipconfig /flushdns
echo.

echo Reset del catalogo Winsock...
netsh winsock reset
echo.

echo Reset dello stack TCP/IP...
netsh int ip reset
echo.

echo Reimpostazione del firewall di Windows...
netsh advfirewall reset
echo.

echo Pulizia cache DNS resolver...
ipconfig /registerdns
echo.

echo Riavvio dei servizi di rete principali...

echo Arresto servizio DHCP Client...
net stop dhcp
echo Avvio servizio DHCP Client...
net start dhcp

echo Arresto servizio Client DNS...
net stop dnscache
echo Avvio servizio Client DNS...
net start dnscache

echo Arresto servizio Network List...
net stop netprofm
echo Avvio servizio Network List...
net start netprofm

echo.

echo Tutte le operazioni di riparazione sono state completate.
echo Il sistema verra' riavviato in 10 secondi...

timeout /t 10 /nobreak

shutdown /r /t 0
