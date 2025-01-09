@echo off
:: Komut İstemi'ni Türkçe karakterlere uygun hale getirin
chcp 65001 >nul
cls

:: Kullanıcıdan port numarasını al
set /p port=Port numarasını girin: 

:: Port numarasına karşılık gelen Process ID'yi bul
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :%port%') do (
    set pid=%%a
    goto :kill
)

echo Belirtilen port numarasına karşılık gelen bir işlem bulunamadı.
pause
exit /b

:kill
:: Process ID'yi öldürmeye çalış
echo Port %port% için Process ID bulundu: %pid%
taskkill /F /PID %pid% >nul 2>&1
if %errorlevel% neq 0 (
    echo Erişim reddedildi veya işlem sonlandırılamadı. Yönetici olarak tekrar deneyin.
) else (
    echo İşlem başarıyla sonlandırıldı.
)
pause
exit /b
