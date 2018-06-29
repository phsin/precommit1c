rem Запускаем в рабочем каталоге
rem SET work=C:\1C\prioskol\Complex\ExtForms\test\
SET work=%CD%
rem 1 записываем все текущие изменения, если что-то не закомичено
cd %work%
git add .
git commit -m "Текущие изменения %DATE%"
pause

rem 2 получаем все изменения из репозитария
rem cd C:\1C\!vetrf_internal
cd C:\1C\!Меркурий
git pull
pause

rem 3 копируем в рабочий каталог
cd C:\1C\!Меркурий\ExtForms
copy *.ert %work%
rem copy Меркурий_*.ert %work%
rem copy ВСД_*.ert %work%
pause 

rem 4 в рабочем каталоге записываем изменения из репозитария
cd %work%
git add .
git commit -m "изменения git_test %DATE%"