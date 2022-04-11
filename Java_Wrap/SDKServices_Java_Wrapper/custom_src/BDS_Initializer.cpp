#include "BDS_Initializer.h"



#ifdef __cplusplus
extern "C" {
#endif

int BDS_PlugCB(const int i_i_deviceHandle, void * const i_p_userData)
{
	//BDS_Notification_Handler* handler = reinterpret_cast<BDS_Notification_Handler*>(i_p_userData);
	//return handler->plug(i_i_deviceHandle);
	
	BDS_Initializer* context = reinterpret_cast<BDS_Initializer*>(i_p_userData);
	context->plug(i_i_deviceHandle);
}

int BDS_UnplugCB(const int i_i_deviceHandle, void * const i_p_userData)
{
	//BDS_Notification_Handler* handler = reinterpret_cast<BDS_Notification_Handler*>(i_p_userData);
	//return handler->unplug(i_i_deviceHandle);

	BDS_Initializer* context = reinterpret_cast<BDS_Initializer*>(i_p_userData);
	context->unplug(i_i_deviceHandle);

}

#ifdef __cplusplus
} // extern "C"
#endif


BDS_Initializer::BDS_Initializer()
	: m_handler(0)/*,
	m_plug_status(NOT_INITIALIZED),
	m_dev_handle(0),
	m_state(STOPPED),
	m_thread_process(HANDLE_NULL)*/
{
};
BDS_Initializer::~BDS_Initializer()
{ 
	delete m_handler; 
	m_handler = 0; 
};
int BDS_Initializer::uninitialize()
{
	delete m_handler; 
	m_handler = 0; 
	return BDS_Uninitialize();
	//stop();
};

int BDS_Initializer::initialize(BDS_Notification_Handler *handler)
{
	delete m_handler;
	m_handler = 0; 
	m_handler = handler;
	
	return BDS_Initialize(BDS_PlugCB, BDS_UnplugCB,(T__PtrC)this);
	//run();
};

int BDS_Initializer::plug(const int dev_handle)
{
	int ret = -1;
	if(m_handler) ret = m_handler->plug(dev_handle);
	return ret;
}
int BDS_Initializer::unplug(const int dev_handle)
{
	int ret = -1;
	if(m_handler) ret = m_handler->unplug(dev_handle);
	return ret;
}

BDS_Notification_Handler* BDS_Initializer::getHandler()
{
	return m_handler;
}


//void BDS_Initializer::notify(void* i_initializer_obj)
//{
//	while(m_state == RUNNING)
//	{
//		if(m_handler !=  NULL)
//		{
//			switch(m_plug_status){
//				case OK :
//					m_handler->plug(m_dev_handle);
//					break;
//				case UNPLUGGED :
//					m_handler->unplug(m_dev_handle);
//					break;
//				case NOT_INITIALIZED:
//					break;
//			}
//		}
//		BDS_OS_Sleep(10);
//	}
//}

//int BDS_Initializer::plugCB(const int i_i_deviceHandle, void * const i_p_userData)
//{
//
//}
//
//int BDS_Initializer::unplugCB(const int i_i_deviceHandle, void * const i_p_userData)
//{
//
//}



//void BDS_Initializer::run()
//{
//	stop();
//	m_state = RUNNING;
//	m_thread_process = BDS_OS_StartThread(notify, 0u, this);
//}
//
//void BDS_Initializer::stop()
//{
//	if(m_state != STOPPED)
//	{
//		m_state = STOPPING;
//		BDS_OS_GetExitCodeThread(m_thread_process, NULL);
//		m_thread_process = HANDLE_NULL;
//	}
//}



//void BDS_Initializer::setPlugStatus(BDS_PlugStatus i_status)
//{
//	m_plug_status = i_status;
//}
//
//BDS_PlugStatus getPlugStatus()
//{
//	return m_plug_status;
//}
//
//void BDS_Initializer::setDevHandle(const int i_dev_handle)
//{
//	m_dev_handle = i_dev_handle;
//}
//
//const int BDS_Initializer::getDevHandle()
//{
//	return m_dev_handle;
//}