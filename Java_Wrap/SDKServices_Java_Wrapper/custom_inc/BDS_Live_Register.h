#if !defined(BDS_Live_Register_H)
#define BDS_Live_Register_H

#include "BDS_Live_Handler.h"
using namespace std;

class BDS_Live_Register
{
	private:
	BDS_Live_Handler& m_handler;
	public:
	BDS_Live_Register(BDS_Live_Handler& i_handler);
	~BDS_Live_Register();

	/*int register_live_handler(BDS_Live_Handler& handler);
	void unregister_live_handler();*/

	int defineLiveProcess(int device_handle);

	int live(int i_i_deviceHandle,
		// BDS_Image
		const T__UChar *  buffer, 
		int width, 
		int height,
		int count,
		// in/out data
		const string & i_p_inputData,
		T__UChar * const  o_p_outputData);

};

#endif