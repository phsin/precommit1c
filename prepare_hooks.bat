cd .git\hooks
del convert_utf8.sh
del pyv8unpack.py

rem %cd% - ���� � ������� �����, ��� ���������� �������� (\)
rem %~dp0 - ���� � ����� �� ������� ��� ������� ������, ������������� ��������� (\)
mklink %~dp0.git\hooks\pyv8unpack.py %~dp0pyv8unpack.py 
mklink %~dp0.git\hooks\convert_utf8.sh %~dp0convert_utf8.sh
mklink %~dp0.git\hooks\clean_dir2.bat %~dp0clean_dir2.bat

