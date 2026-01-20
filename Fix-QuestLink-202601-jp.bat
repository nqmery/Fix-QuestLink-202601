@echo off

echo ==========================================
echo Quest Linkの不具合に対する応急処置プログラム
echo 2026年1月20日
echo ==========================================
echo.

rem 管理者権限の確認
NET SESSION > NUL 2>&1
IF %ERRORLEVEL% == 0 (
    GOTO PROCESS
) ELSE (
    ECHO 実行には管理者権限が必要です。
    ECHO このファイルを右クリックし、「管理者として実行」をクリックしてください。
    ECHO 処理を中断します。
    pause
    EXIT /B 1
)

:PROCESS

ECHO 実行したい処理の番号を半角英数字で入力し、ENTERキーを押してください。
ECHO.
ECHO 1: Quest Link 不具合の応急処置
ECHO 2: 応急処置の解除
ECHO 3: 終了
ECHO.
set /p choice=選択肢を入力してください（1/2/3）:
ECHO.

IF "%choice%"=="3" (
    ECHO 処理は行われませんでした
    GOTO END
)
IF "%choice%"=="1" (
    ECHO Quest Linkの不具合に対する応急処置を実行します...
    netsh advfirewall firewall set rule name="oculus-dash:dash\bin\OculusDash.exe Outbound" new enable=no
    netsh advfirewall firewall add rule name="oculus-dash一時無効化" dir=out program="%ProgramFiles%\Oculus\Support\oculus-dash\dash\bin\OculusDash.exe" action=block
    ECHO 「OK」が2回表示されていれば、応急処置が正常に完了しています。
    ECHO Meta社公式による不具合対応が行われた後、本プログラムを用いて応急処置の解除を行うことをおすすめします。
    GOTO END
)
IF "%choice%"=="2" (
    ECHO 応急処置の解除を実行します...
    netsh advfirewall firewall delete rule name="oculus-dash一時無効化"
    netsh advfirewall firewall set rule name="oculus-dash:dash\bin\OculusDash.exe Outbound" new enable=yes
    ECHO 「OK」が2回表示されていれば、応急処置の解除が正常に完了しています。
    GOTO END
)


:END
ECHO.
ECHO プログラムを終了します
pause
EXIT /B 0