@echo off
SETLOCAL

rem ----------------------------------------------------------------------------
rem SDK MorphoTop Android wrapper generation script
rem ----------------------------------------------------------------------------


echo SDK MorphoTop Android wrapper generation script

rem ----------------------------------------------------------------------------
rem Prepare paths
rem ----------------------------------------------------------------------------

rem SWIG_HOME must be defined as environment variable

Set SWIG_CMD=%SWIG_HOME%\swig.exe


call :TestFile %SWIG_CMD%
Set SDK_SRC_LOCATION=%~dp0..\..
rem SDK_SRC_LOCATION must be modified depending on SDK sources location
if "%SDK_SRC_LOCATION%" == "" (
	echo The SDK MTOP sources root dircetory -SDK_SRC_LOCATION- is not defined
	Set SDK_SRC_LOCATION=%~dp0..\..
	echo Setting SDK_SRC_LOCATION to "%SDK_SRC_LOCATION%"
)
echo Setting SDK_SRC_LOCATION to "%SDK_SRC_LOCATION%"
rem Set SDK_SRC_LOCATION=D:\morphotop-sdk-android\SDK


Set SWIG_INTERFACE_FILES_LOCATION=%SDK_SRC_LOCATION%\Wrappers\SDKServices_Java_Wrapper\swig_interfaces
Set SWIG_SDK_INCLUDES_LOCATION=%SDK_SRC_LOCATION%\Interfaces
rem Custom includes for callbacks wrapping ..
Set SWIG_SDK_CUSTOM_INCLUDES_LOCATION=%SDK_SRC_LOCATION%\Wrappers\SDKServices_Java_Wrapper\custom_inc


Set SWIG_GENERATED_JNI_FILES_LOCATION=%SDK_SRC_LOCATION%\Android\jni\sdk
Set SWIG_GENERATED_JNI_FILES_INC_LOCATION=%SWIG_GENERATED_JNI_FILES_LOCATION%\inc
Set SWIG_GENERATED_JNI_FILES_SRC_LOCATION=%SWIG_GENERATED_JNI_FILES_LOCATION%\src
Set SWIG_GENERATED_JAVA_FILES_LOCATION=%SDK_SRC_LOCATION%\Android\java\morpho.morphotop.api\src\main\java\com\morpho\morphotop\api
if "%~1" == "clean" (
	
	rd /s /q %SWIG_GENERATED_JNI_FILES_LOCATION%
	del /s /q %SWIG_GENERATED_JAVA_FILES_LOCATION%\*.java
	
	goto success
)

call :TestDirectory %SWIG_GENERATED_JNI_FILES_LOCATION% message
call :TestDirectory %SWIG_SDK_INCLUDES_LOCATION% message
call :TestDirectory %SWIG_SDK_CUSTOM_INCLUDES_LOCATION% message

call :TestDirectory %SWIG_GENERATED_JNI_FILES_LOCATION% create
call :TestDirectory %SWIG_GENERATED_JNI_FILES_INC_LOCATION% create
call :TestDirectory %SWIG_GENERATED_JNI_FILES_SRC_LOCATION% create
call :TestDirectory %SWIG_GENERATED_JAVA_FILES_LOCATION% create



rem ----------------------------------------------------------------------------
rem Generate jni/java file
rem ----------------------------------------------------------------------------

echo In order to function correctly, please ensure the following environment variables are correctly set:
echo JAVA_INCLUDE: %JAVA_INCLUDE%
echo JAVA_BIN: %JAVA_BIN%

cd  %SWIG_GENERATED_JNI_FILES_LOCATION%

%SWIG_CMD% -c++  -java -package com.morpho.morphotop.api -I%SWIG_INTERFACE_FILES_LOCATION% -I%SWIG_SDK_INCLUDES_LOCATION% -I%SWIG_SDK_CUSTOM_INCLUDES_LOCATION% -outcurrentdir -outdir %SWIG_GENERATED_JAVA_FILES_LOCATION% %SWIG_INTERFACE_FILES_LOCATION%\ProxyBDS_Interface_XCS.i
rem %SWIG_CMD% -c++  -java -package com.morpho.morphotop.api -I%SWIG_INTERFACE_FILES_LOCATION% -I%SWIG_SDK_INCLUDES_LOCATION% -I%SWIG_SDK_CUSTOM_INCLUDES_LOCATION% -outcurrentdir -outdir %SWIG_GENERATED_JAVA_FILES_LOCATION% %SWIG_INTERFACE_FILES_LOCATION%\ProxyBDS_Notification_Handler.i
%SWIG_CMD% -c++  -java -package com.morpho.morphotop.api -I%SWIG_INTERFACE_FILES_LOCATION% -I%SWIG_SDK_INCLUDES_LOCATION% -I%SWIG_SDK_CUSTOM_INCLUDES_LOCATION% -outcurrentdir -outdir %SWIG_GENERATED_JAVA_FILES_LOCATION% %SWIG_INTERFACE_FILES_LOCATION%\ProxyBDS_Initializer.i
rem %SWIG_CMD% -c++  -java -package com.morpho.morphotop.api -I%SWIG_INTERFACE_FILES_LOCATION% -I%SWIG_SDK_INCLUDES_LOCATION% -I%SWIG_SDK_CUSTOM_INCLUDES_LOCATION% -outcurrentdir -outdir %SWIG_GENERATED_JAVA_FILES_LOCATION% %SWIG_INTERFACE_FILES_LOCATION%\ProxyBDS_Live_Handler.i
%SWIG_CMD% -c++  -java -package com.morpho.morphotop.api -I%SWIG_INTERFACE_FILES_LOCATION% -I%SWIG_SDK_INCLUDES_LOCATION% -I%SWIG_SDK_CUSTOM_INCLUDES_LOCATION% -outcurrentdir -outdir %SWIG_GENERATED_JAVA_FILES_LOCATION% %SWIG_INTERFACE_FILES_LOCATION%\ProxyBDS_Live_Register.i


 FOR %%F IN (DIR %SWIG_GENERATED_JNI_FILES_LOCATION%\*.h) DO IF NOT "%%F"=="DIR"  move %%F %SWIG_GENERATED_JNI_FILES_INC_LOCATION%\
 FOR %%F IN (DIR %SWIG_GENERATED_JNI_FILES_LOCATION%\*.cxx) DO IF NOT "%%F"=="DIR"  move %%F %SWIG_GENERATED_JNI_FILES_SRC_LOCATION%\
 
 FOR %%F IN (DIR %SWIG_GENERATED_JNI_FILES_LOCATION%\*.h) DO IF NOT "%%F"=="DIR"  echo %%F
 FOR %%F IN (DIR %SWIG_GENERATED_JNI_FILES_LOCATION%\*.cxx) DO IF NOT "%%F"=="DIR" echo %%F
 
 goto success


:success
	echo SDK MorphoTop Android wrapper generation script success
	if not "%~1" == "--no-pause" pause
	ENDLOCAL
	exit /B 0


:TestFile
	if not exist "%~1" (
		echo "%~1 doesn't exist !"
		goto failure
	)
	
	exit /B 0
	
:TestDirectory
	if not exist "%~1" (
		if "%~2" == "create" (
			mkdir "%~1"
		) else (
			if "%~2" == "message"	echo         The path "%~1" does not exists
			exit /B 1
		)
	)

	exit /B 0


:failure
	echo SDK MorphoTop Android wrapper generation script failed
	if not "%~1" == "--no-pause" pause
	ENDLOCAL
	exit /B 1
	
