@echo off
chcp 1251 > nul
set PROGRAM="Triangle_C.exe"
if %PROGRAM% == "" goto err

echo|set /p="Проверка недостаточности параметров = "
%PROGRAM% > nul
if %ERRORLEVEL% EQU 0 goto testFailed
%PROGRAM% 1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
%PROGRAM% 1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
%PROGRAM% 1 1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
echo OK

echo|set /p="Проверка на избыток параметров = "
%PROGRAM% 1 1 1 1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
echo OK

echo|set /p="Проверка пустых параметров = "
%PROGRAM% "" "" "" > nul
if %ERRORLEVEL% EQU 0 goto testFailed
echo OK

echo|set /p="Проверка отрицательной стороны треугольника = "
%PROGRAM% 1 1 -1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
%PROGRAM% -1 1 1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
%PROGRAM% 1 -1 1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
echo OK

echo|set /p="Проверка одного пустого параметра длины треугольника = "
%PROGRAM% 1 1 "" > nul
if %ERRORLEVEL% EQU 0 goto testFailed
%PROGRAM% 1 "" 1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
%PROGRAM% "" 1 1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
echo OK

echo|set /p="Проверка буквы, входящей в состав значения стороны одной из длин треугольника = "
%PROGRAM% 1 1 1a > nul
if %ERRORLEVEL% EQU 0 goto testFailed
%PROGRAM% 1 1e 1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
%PROGRAM% 1x 1 1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
echo OK

echo|set /p="Проверка буквенного значения одной из длин треугольника = "
%PROGRAM% 1 a 1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
%PROGRAM% 1 1 b > nul
if %ERRORLEVEL% EQU 0 goto testFailed
%PROGRAM% b 1 1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
echo OK

echo|set /p="Проверка превыщения знаков при указании длинн сторон = "
%PROGRAM% 999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999.9 999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999.9 999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999.9 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
echo OK

echo|set /p="Проверка длин сторон 1 1.1 1,1 и замена точки на запятую = "
%PROGRAM% 1 1.1 1,1 > nul
if %ERRORLEVEL% EQU 1 goto testFailed
echo OK

echo|set /p="Определение треугольника с длинами сторон 5.2 5.2 5.2 как равностороннего треугольника = "
%PROGRAM% 5.2 5.2 5.2 > output.txt
if %ERRORLEVEL% EQU 1 goto testFailed
fc.exe %TEMP%\output.txt Equilateral.txt > nul
if %ERRORLEVEL% EQU 0 goto testFailed
echo OK

echo|set /p="Определение треугольника с длинами сторон 100 2 1 как не треугольника = "
%PROGRAM% 100 2 1 > output.txt
if %ERRORLEVEL% EQU 1 goto testFailed
fc.exe %TEMP%\output NotTriangle.txt > nul
if %ERRORLEVEL% EQU 0 goto testFailed
echo OK

echo|set /p="Определение треугольника с длинами сторон 3 2.5 4 как обычного = "
%PROGRAM% 3 2.5 4 > output.txt
if %ERRORLEVEL% EQU 1 goto testFailed
fc.exe %TEMP%\output Normal.txt > nul
if %ERRORLEVEL% EQU 0 goto testFailed
echo OK


echo|set /p="Определение треугольника с длинами сторон 5.4 5.4 4 как равнобедренного = "
%PROGRAM% 5.4 5.4 4 > output.txt
if %ERRORLEVEL% EQU 1 goto testFailed
fc.exe %TEMP%\output Isosceles.txt > nul
if %ERRORLEVEL% EQU 0 goto testFailed
echo OK


echo Тестирование завершено успешно
exit /B 0

:testFailed
echo FAILED
echo Тестирование не пройдено
exit /B 1