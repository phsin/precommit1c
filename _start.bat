rem ����᪠�� � ࠡ�祬 ��⠫���
rem SET work=C:\1C\prioskol\Complex\ExtForms\test\
SET work=%CD%
rem 1 �����뢠�� �� ⥪�騥 ���������, �᫨ ��-� �� ������祭�
cd %work%
git add .
git commit -m "����騥 ��������� %DATE%"
pause

rem 2 ����砥� �� ��������� �� ९������
cd C:\1C\!vetrf_internal
git pull
pause

rem 3 �����㥬 � ࠡ�稩 ��⠫��
cd C:\1C\!vetrf_internal\ExtForms
copy *.ert %work%
rem copy ����਩_*.ert %work%
rem copy ���_*.ert %work%
pause 

rem 4 � ࠡ�祬 ��⠫��� �����뢠�� ��������� �� ९������
cd %work%
git add .
git commit -m "��������� git %DATE%"