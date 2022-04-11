#if !defined(BDS_Live_Handler_H)
#define BDS_Live_Handler_H

#include "BDS_Interface_XCS.h"
#include <string.h>
#include <string>
#ifdef ANDROID
#include <android/log.h>
#endif
#define BOXE_SIZE 4
#define BOXES_COUNT 4

using namespace std;
class BDS_Live_Handler{
	public:
		virtual ~BDS_Live_Handler() {
		};
		virtual int live(int i_i_deviceHandle,
			// BDS_Image
			const T__UChar *  buffer, 
			int width, 
			int height,
			int count,
			// in/out data
			const string & i_p_inputData,
			T__UChar * const  o_p_outputData) = 0;/* {
			#ifdef ANDROID
			__android_log_print(ANDROID_LOG_DEBUG, "MTOP-NATIVE", "C++ LIVE ..  "); 
			#endif
			return 0;
		};*/

};

#endif