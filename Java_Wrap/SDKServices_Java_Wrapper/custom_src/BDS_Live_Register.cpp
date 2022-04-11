#include "BDS_Live_Register.h"
#include <stdio.h>

#include <iostream>
#include <sstream>


using namespace std;
#ifdef __cplusplus
extern "C" {
#endif

T__SInt32 live_callback (const T__SInt32 i_i_deviceHandle,
								BDS_Image * const i_p_currentImage,
								const T__UChar * const i_p_inputData,
								T__UChar * const o_p_outputData,
								T__Ptr const i_p_userData)
{
	BDS_Live_Register* context = reinterpret_cast<BDS_Live_Register*>(i_p_userData);

	BDS_DetectionResults * l_px_DetectionResults = NULL;

	std::string inData = "";

	memcpy(&l_px_DetectionResults, &(i_p_inputData[1]), sizeof(BDS_DetectionResults *));
	if(l_px_DetectionResults != NULL)
	{
		std::stringstream ss;
		ss << l_px_DetectionResults->m_detectionStatus << ":";
		ss << l_px_DetectionResults->m_finger1 << ":";
		ss << l_px_DetectionResults->m_finger2 << ":";
		ss << l_px_DetectionResults->m_finger3 << ":";
		ss << l_px_DetectionResults->m_finger4 << ":";

		for(int i = 0; i < BOXES_COUNT;++i)
		{
			ss << l_px_DetectionResults->m_boxes[i].m_startingColumn << ":";
			ss << l_px_DetectionResults->m_boxes[i].m_startingLine << ":";
			ss << l_px_DetectionResults->m_boxes[i].m_width << ":";
			ss << l_px_DetectionResults->m_boxes[i].m_height << ":";
		}

		ss << l_px_DetectionResults->m_leftFlag << ":";                         
		ss << l_px_DetectionResults->m_rightFlag << ":";
		ss << l_px_DetectionResults->m_topFlag << ":";
		ss << l_px_DetectionResults->m_bottomFlag << ":";
		ss << l_px_DetectionResults->m_tooTightFlag << ":";
		ss << l_px_DetectionResults->m_tooSpreadFlag << std::endl;
		inData = ss.str();
		
	}

	/*BDS_DetectionResults_bis drb;
	memset(&drb, 0, sizeof(BDS_DetectionResults_bis));

	BDS_DetectionResults * l_px_DetectionResults = NULL;
    
	memcpy(&l_px_DetectionResults, &(i_p_inputData[1]), sizeof(BDS_DetectionResults *));
	
	BDS_DetectionResults dr;
	memset(&dr, 0, sizeof(BDS_DetectionResults));
	if(l_px_DetectionResults != NULL)
	{
		dr = *l_px_DetectionResults;

		drb.m_detectionStatus = l_px_DetectionResults->m_detectionStatus;
		drb.m_finger1 = l_px_DetectionResults->m_finger1;
		drb.m_finger2 = l_px_DetectionResults->m_finger2;
		drb.m_finger3 = l_px_DetectionResults->m_finger3;
		drb.m_finger4 = l_px_DetectionResults->m_finger4;

		drb.m_boxe1[0] = l_px_DetectionResults->m_boxes[0].m_startingColumn;
		drb.m_boxe1[1] = l_px_DetectionResults->m_boxes[0].m_startingLine;
		drb.m_boxe1[2] = l_px_DetectionResults->m_boxes[0].m_width;
		drb.m_boxe1[3] = l_px_DetectionResults->m_boxes[0].m_height;
		__android_log_print(ANDROID_LOG_ERROR, "MTOP-NATIVE", "C++ LIVE 1 (%d,%d,%d,%d)", 
				drb.m_boxe1[0], drb.m_boxe1[1], drb.m_boxe1[2], drb.m_boxe1[3]);

		drb.m_boxe2[0] = l_px_DetectionResults->m_boxes[1].m_startingColumn;
		drb.m_boxe2[1] = l_px_DetectionResults->m_boxes[1].m_startingLine;
		drb.m_boxe2[2] = l_px_DetectionResults->m_boxes[1].m_width;
		drb.m_boxe2[3] = l_px_DetectionResults->m_boxes[1].m_height;
		__android_log_print(ANDROID_LOG_ERROR, "MTOP-NATIVE", "C++ LIVE 1 (%d,%d,%d,%d)", 
				drb.m_boxe2[0], drb.m_boxe2[1], drb.m_boxe2[2], drb.m_boxe2[3]);


		drb.m_boxe3[0] = l_px_DetectionResults->m_boxes[2].m_startingColumn;
		drb.m_boxe3[1] = l_px_DetectionResults->m_boxes[2].m_startingLine;
		drb.m_boxe3[2] = l_px_DetectionResults->m_boxes[2].m_width;
		drb.m_boxe3[3] = l_px_DetectionResults->m_boxes[2].m_height;
		__android_log_print(ANDROID_LOG_ERROR, "MTOP-NATIVE", "C++ LIVE 1 (%d,%d,%d,%d)", 
				drb.m_boxe3[0], drb.m_boxe3[1], drb.m_boxe3[2], drb.m_boxe3[3]);


		drb.m_boxe4[0] = l_px_DetectionResults->m_boxes[3].m_startingColumn;
		drb.m_boxe4[1] = l_px_DetectionResults->m_boxes[3].m_startingLine;
		drb.m_boxe4[2] = l_px_DetectionResults->m_boxes[3].m_width;
		drb.m_boxe4[3] = l_px_DetectionResults->m_boxes[3].m_height;
		__android_log_print(ANDROID_LOG_ERROR, "MTOP-NATIVE", "C++ LIVE 1 (%d,%d,%d,%d)", 
				drb.m_boxe4[0], drb.m_boxe4[1], drb.m_boxe4[2], drb.m_boxe4[3]);

		drb.m_leftFlag = l_px_DetectionResults->m_leftFlag;                         
		drb.m_rightFlag = l_px_DetectionResults->m_rightFlag;
		drb.m_topFlag = l_px_DetectionResults->m_topFlag;
		drb.m_bottomFlag = l_px_DetectionResults->m_bottomFlag;
		drb.m_tooTightFlag = l_px_DetectionResults->m_tooTightFlag;
		drb.m_tooSpreadFlag = l_px_DetectionResults->m_tooSpreadFlag;

	}

*/

 //   drb.m_boxe1 = l_px_DetectionResults->m_boxes[0];
	//drb.m_boxe2 = l_px_DetectionResults->m_boxes[1];
	//drb.m_boxe3 = l_px_DetectionResults->m_boxes[2];
	//drb.m_boxe4 = l_px_DetectionResults->m_boxes[3];

	return context->live(i_i_deviceHandle,(const T__UChar *)i_p_currentImage->m_image,i_p_currentImage->m_width, i_p_currentImage->m_height,i_p_currentImage->m_count,(const string &)inData,o_p_outputData);
}

#ifdef __cplusplus
}
#endif


BDS_Live_Register::BDS_Live_Register(BDS_Live_Handler& i_handler)
	: m_handler(i_handler)
{
};

BDS_Live_Register::~BDS_Live_Register() 
{ 
};


int BDS_Live_Register::defineLiveProcess(int device_handle)
{
	return BDS_DefineLiveProcess((const T__SInt32)device_handle, live_callback);
}


int BDS_Live_Register::live(int i_i_deviceHandle,
		// BDS_Image
		const T__UChar *  buffer, 
		int width, 
		int height,
		int count,
		// in/out data
		const string & i_p_inputData,
		T__UChar * const  o_p_outputData)
{
	int ret = -1;
	ret = m_handler.live(i_i_deviceHandle,buffer,width,height,count,i_p_inputData,o_p_outputData);
	return ret;
}