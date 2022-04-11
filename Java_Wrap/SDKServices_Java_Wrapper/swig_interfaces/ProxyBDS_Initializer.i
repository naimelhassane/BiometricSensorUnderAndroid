/* File : ProxyBDS_Initializer.i */
%module(directors="1") ProxyBDS_Initializer
%{
#include "BDS_Initializer.h"
#include "android/log.h"
%}

%include "std_string.i"

%include ProxyBDS_Types.i

/* turn on director wrapping BDS_Notification_Handler */
%feature("director") BDS_Notification_Handler;
%apply unsigned char *NIOBUFFER {const T__UChar *, T__UChar * const, T__Ptr		m_image}
 
%include "BDS_Notification_Handler.h"

%ignore BDS_PlugCB;
%ignore BDS_UnplugCB;


%include "BDS_Initializer.h"