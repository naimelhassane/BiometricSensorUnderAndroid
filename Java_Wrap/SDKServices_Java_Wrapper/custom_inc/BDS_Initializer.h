#if !defined(BDS_Initializer_H)
#define BDS_Initializer_H
#include "jni.h"
#include "BDS_Notification_Handler.h"
#include "BDS_Interface_XCS.h"
#include "BDS_OS.h"

class BDS_Initializer
{
private:
	BDS_Notification_Handler *m_handler;

public:
	BDS_Initializer();
	~BDS_Initializer();
	int uninitialize();
	int initialize(BDS_Notification_Handler *handler);
	BDS_Notification_Handler* getHandler();
	int plug(const int dev_handle);
	int unplug(const int dev_handle);
};

#endif