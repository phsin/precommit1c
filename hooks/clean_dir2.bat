@echo off
rem chcp 1251
                :: file - ��� ��� ��᪠ ����� ��� 㤠�����
rem set "file=��ꥪ�댥⠤�����.txt"
                :: from - ��� �����, � ���ன ��稭��� �᪠�� �����
                :: �������騩 ����� \ ��� ��᪠ - ��易⥫��,
                :: ����� ��������� ��� �������饣� \
 
set "from=%1"
rem set "from=c:\"
 
set "file=��ꥪ�댥⠤�����.txt"
call :delall-file "%file%" "%from%"
set "file=�������.mdp"
call :delall-file "%file%" "%from%"
rem set "file=��ଠ.frm"
rem call :delall-file "%file%" "%from%"
set "file=���冷���ꥪ⮢.ord"
call :delall-file "%file%" "%from%"
set "file=������.mxl"
call :delall-file "%file%" "%from%"
set "file=���ᠭ��.txt"
call :delall-file "%file%" "%from%"

rem pause
exit /b
rem break
 
:delall-file
rem echo 㤠���� ���������� 䠩�� � ������ "%file%",
rem echo ��稭�� � ����� "%from%" ?
echo delete file "%file%" from "%from%"
echo.
rem pause
rem echo....������� �௥��� - ४��ᨢ�� ��� 䠩�� ��稭�� � ����� %from%
 
                :: 㤠���� echo � ᫥���饩 ��ப�, �⮡� ������� ���������� �� 䠩���
 
for /f "tokens=*" %%v in ('where /r %~s2 /f %~snx1') do (
echo del %%v
del %%v
)

exit /b