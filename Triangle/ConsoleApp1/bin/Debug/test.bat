@echo off
chcp 1251 > nul
set PROGRAM="Triangle_C.exe"
if %PROGRAM% == "" goto err

echo|set /p="�������� ��������������� ���������� = "
%PROGRAM% > nul
if %ERRORLEVEL% EQU 0 goto testFailed
%PROGRAM% 1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
%PROGRAM% 1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
%PROGRAM% 1 1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
echo OK

echo|set /p="�������� �� ������� ���������� = "
%PROGRAM% 1 1 1 1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
echo OK

echo|set /p="�������� ������ ���������� = "
%PROGRAM% "" "" "" > nul
if %ERRORLEVEL% EQU 0 goto testFailed
echo OK

echo|set /p="�������� ������������� ������� ������������ = "
%PROGRAM% 1 1 -1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
%PROGRAM% -1 1 1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
%PROGRAM% 1 -1 1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
echo OK

echo|set /p="�������� ������ ������� ��������� ����� ������������ = "
%PROGRAM% 1 1 "" > nul
if %ERRORLEVEL% EQU 0 goto testFailed
%PROGRAM% 1 "" 1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
%PROGRAM% "" 1 1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
echo OK

echo|set /p="�������� �����, �������� � ������ �������� ������� ����� �� ���� ������������ = "
%PROGRAM% 1 1 1a > nul
if %ERRORLEVEL% EQU 0 goto testFailed
%PROGRAM% 1 1e 1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
%PROGRAM% 1x 1 1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
echo OK

echo|set /p="�������� ���������� �������� ����� �� ���� ������������ = "
%PROGRAM% 1 a 1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
%PROGRAM% 1 1 b > nul
if %ERRORLEVEL% EQU 0 goto testFailed
%PROGRAM% b 1 1 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
echo OK

echo|set /p="�������� ���������� ������ ��� �������� ����� ������ = "
%PROGRAM% 999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999.9 999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999.9 999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999.9 > nul
if %ERRORLEVEL% EQU 0 goto testFailed
echo OK

echo|set /p="�������� ���� ������ 1 1.1 1,1 � ������ ����� �� ������� = "
%PROGRAM% 1 1.1 1,1 > nul
if %ERRORLEVEL% EQU 1 goto testFailed
echo OK

echo|set /p="����������� ������������ � ������� ������ 5.2 5.2 5.2 ��� ��������������� ������������ = "
%PROGRAM% 5.2 5.2 5.2 > output.txt
if %ERRORLEVEL% EQU 1 goto testFailed
fc.exe %TEMP%\output.txt Equilateral.txt > nul
if %ERRORLEVEL% EQU 0 goto testFailed
echo OK

echo|set /p="����������� ������������ � ������� ������ 100 2 1 ��� �� ������������ = "
%PROGRAM% 100 2 1 > output.txt
if %ERRORLEVEL% EQU 1 goto testFailed
fc.exe %TEMP%\output NotTriangle.txt > nul
if %ERRORLEVEL% EQU 0 goto testFailed
echo OK

echo|set /p="����������� ������������ � ������� ������ 3 2.5 4 ��� �������� = "
%PROGRAM% 3 2.5 4 > output.txt
if %ERRORLEVEL% EQU 1 goto testFailed
fc.exe %TEMP%\output Normal.txt > nul
if %ERRORLEVEL% EQU 0 goto testFailed
echo OK


echo|set /p="����������� ������������ � ������� ������ 5.4 5.4 4 ��� ��������������� = "
%PROGRAM% 5.4 5.4 4 > output.txt
if %ERRORLEVEL% EQU 1 goto testFailed
fc.exe %TEMP%\output Isosceles.txt > nul
if %ERRORLEVEL% EQU 0 goto testFailed
echo OK


echo ������������ ��������� �������
exit /B 0

:testFailed
echo FAILED
echo ������������ �� ��������
exit /B 1