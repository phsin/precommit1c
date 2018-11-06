@echo off
                :: file - имя или маска жертвы для удаления
rem set "file=ОбъектыМетаданных.txt"
                :: from - имя папки, с которой начинаем искать жертву
                :: завершающий обратный \ для диска - обязателен,
                :: папка кодируется БЕЗ завершающего \
 
set "from=%1"
rem set "from=c:\"
 
call :delall-file "file=ОбъектыМетаданных.txt" "%from%"
call :delall-file "file=Структура.mdp" "%from%"
call :delall-file "file=Форма.frm" "%from%"
call :delall-file "file=ПорядокОбъектов.ord" "%from%"
call :delall-file "file=Таблица.mxl" "%from%"
call :delall-file "file=Описание.txt" "%from%"

rem pause
exit /b
 
:delall-file
echo удалить РЕКУРСИВНО файлы с именем "%file%",
echo начиная с папки "%from%" ?
echo.
rem pause
echo....наберись терпения - рекурсивно ищу файлы начиная с папки %from%
 
                :: удалить echo в следующей строке, чтобы РЕАЛЬНО избавиться от файлов
 
for /f "tokens=*" %%v in ('where /r %~s2 /f %~snx1') do (
echo del %%v
del %%v
)

exit /b