@echo off
                :: file - ��� ��� ��᪠ ����� ��� 㤠�����
rem set "file=��ꥪ�댥⠤�����.txt"
                :: from - ��� �����, � ���ன ��稭��� �᪠�� �����
                :: �������騩 ����� \ ��� ��᪠ - ��易⥫��,
                :: ����� ��������� ��� �������饣� \
 
set "from=%1"
rem set "from=c:\"
 
call :delall-file "file=��ꥪ�댥⠤�����.txt" "%from%"
call :delall-file "file=�������.mdp" "%from%"
call :delall-file "file=��ଠ.frm" "%from%"
call :delall-file "file=���冷���ꥪ⮢.ord" "%from%"
call :delall-file "file=������.mxl" "%from%"
call :delall-file "file=���ᠭ��.txt" "%from%"

rem pause
exit /b
 
:delall-file
echo 㤠���� ���������� 䠩�� � ������ "%file%",
echo ��稭�� � ����� "%from%" ?
echo.
rem pause
echo....������� �௥��� - ४��ᨢ�� ��� 䠩�� ��稭�� � ����� %from%
 
                :: 㤠���� echo � ᫥���饩 ��ப�, �⮡� ������� ���������� �� 䠩���
 
for /f "tokens=*" %%v in ('where /r %~s2 /f %~snx1') do (
echo del %%v
del %%v
)

exit /b