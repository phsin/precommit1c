rem �� �������� � ������� CMD
rem �������� ������ � bash 
rem �������� � ��������� ���� ������
rem cd %1
for /R %1 %%i in (*.1s) do (
iconv -f cp1251 -t utf-8 "%%~nxi" > "%%~nxi_win"
del "%%~nxi"
rename "%%~nxi_win" %%~nxi
)