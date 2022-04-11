#if !defined(BDS_Notification_Handler_H)
#define BDS_Notification_Handler_H
#include "BDS_Interface_XCS.h"
#ifdef ANDROID
#include <android/log.h>
#endif

class BDS_Notification_Handler{
	public:
		virtual ~BDS_Notification_Handler() {};
		virtual int plug(const int dev_handle){
			#ifdef ANDROID
			__android_log_print(ANDROID_LOG_DEBUG, "MTOP-NATIVE", "C++ PLUG ..  "); 
			#endif
			return 0;
		};
		virtual int unplug(const int dev_handle) {
			#ifdef ANDROID
			__android_log_print(ANDROID_LOG_DEBUG, "MTOP-NATIVE", "C++ UNPLUG ..  "); 
			#endif
			return 0;
		};
};

#endif