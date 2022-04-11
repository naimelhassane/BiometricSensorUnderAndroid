/* File : ProxyBDS_Interface_XCS.i */
%module ProxyBDS_Interface_XCS

%{
#include <android/log.h>
#include "BDS_Interface_XCS.h"
#include "BDS_Live_Register.h"
%}


/* Force the generated Java code to use the C enum values rather than making a JNI call */
%javaconst(1);

/*%include "ProxyBDS_Types.i"*/


%include ProxyBDS_Types.i
%ignore BDS_resolveInterface;
%ignore BDS_Initialize;
%ignore BDS_Uninitialize;
%ignore BDS_DefineDeviceUnpluggedProcess;
%ignore BDS_DefineDeviceNotificationProcess;
%ignore BDS_DefineLiveProcess;


%apply T__UChar *  buffer {const T__UChar *, T__UChar * const}
%apply T__UChar *  buffer1 {T__Ptr		m_image}

%include BDS_Common.h
%include BDS_ViseurB3.h
%include BDS_Live_Handler.h
%include BDS_Live_Register.h

%rename(BDS_OpenBiometricDevice) wrap_BDS_OpenBiometricDevice;
%inline %{
int wrap_BDS_OpenBiometricDevice(const T__SInt32 i_i_deviceIndex,
				T__SInt32 * o_p_deviceHandle,
				BDS_Live_Register* i_p_userData ) {
   BDS_OpenBiometricDevice(i_i_deviceIndex,o_p_deviceHandle,(T__PtrC)i_p_userData);
}
%}


%include "BDS_Interface_XCS.h"




