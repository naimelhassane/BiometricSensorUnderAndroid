/* File : ProxyBDS_Types.i */

%include "typemaps.i"
%include "java.swg"
%include "arrays_java.i";
%include "various.i"
%include "enumtypeunsafe.swg"


%javaconst(1);
%javaconst(0) TRUE;
%javaconst(0) FALSE;
%javaconst(0) BDS_DEFAULT_SERVER_PORT;
%javaconst(0) IMG_RFU_LENGTH;

%include "BDS_Types.h"

/* T__Ptr */

%typemap(jni) T__Ptr "jobject";
%typemap(jtype) T__Ptr "java.lang.Object";
%typemap(jstype) T__Ptr "java.lang.Object";
%typemap(javain) T__Ptr "$javainput";

/* T__PtrC */
%apply T__Ptr {T__Ptr, T__PtrC };




/* BDS_DeviceRolledModeStatus pointer */

%typemap(jni) BDS_DeviceRolledModeStatus * "jobject"
%typemap(jtype) BDS_DeviceRolledModeStatus * "BDS_DeviceRolledModeStatus"
%typemap(jstype) BDS_DeviceRolledModeStatus * "BDS_DeviceRolledModeStatus"

%typemap(argout) BDS_DeviceRolledModeStatus * {
  jclass clazz = jenv->FindClass("morpho/morphotop/api/BDS_DeviceRolledModeStatus");
  jfieldID fid = jenv->GetFieldID(clazz, "swigValue", "I");
  jlong cPtr = 0;
  *(BDS_DeviceRolledModeStatus *)&cPtr = *$1;
  jenv->SetLongField($input, fid, cPtr);
}

%typemap(javain) BDS_DeviceRolledModeStatus * "$javainput"


/* BDS_Image pointer */

/*%typemap(jni) BDS_Image * "jobject"
%typemap(jtype) BDS_Image * "BDS_Image"
%typemap(jstype) BDS_Image * "BDS_Image"

%typemap(argout) BDS_Image * {
  jclass clazz = jenv->FindClass("morpho/morphotop/api/BDS_Image");
  jfieldID fid = jenv->GetFieldID(clazz, "swigCPtr", "J");
  jlong cPtr = 0;
  *(BDS_Image *)&cPtr = *$1;
  jenv->SetLongField($input, fid, cPtr);
}


%typemap(javain) BDS_Image * "$javainput"*/


/* 
 * char **STRING_OUT typemaps. 
 * These are typemaps for returning strings when using a C char ** parameter type.
 * The returned string appears in the 1st element of the passed in Java String array.
 *
 * Example usage wrapping:
 *   %apply char **STRING_OUT { char **string_out };
 *   void foo(char **string_out);
 *  
 * Java usage:
 *   String stringOutArray[] = { "" };
 *   modulename.foo(stringOutArray);
 *   System.out.println( stringOutArray[0] );
 */
%typemap(jni) char **STRING_OUT "jobjectArray"
%typemap(jtype) char **STRING_OUT "String[]"
%typemap(jstype) char **STRING_OUT "String[]"
%typemap(javain) char **STRING_OUT "$javainput"

%typemap(in) char **STRING_OUT($*1_ltype temp) {
  if (!$input) {
    SWIG_JavaThrowException(jenv, SWIG_JavaNullPointerException, "array null");
    return $null;
  }
  if (JCALL1(GetArrayLength, jenv, $input) == 0) {
    SWIG_JavaThrowException(jenv, SWIG_JavaIndexOutOfBoundsException, "Array must contain at least 1 element");
    return $null;
  }
  $1 = &temp; 
  *$1 = 0;
}


%typemap(argout) char **STRING_OUT {
	if($result == 0)
	{
	   jstring jnewstring = NULL;
	   if ($1)
	   {
					   jnewstring = JCALL1(NewStringUTF, jenv, *$1);
	   }
	   JCALL3(SetObjectArrayElement, jenv, $input, 0, jnewstring);
	}
}


%apply char **STRING_OUT {const T__Char ** o_p_string};

%apply int *INPUT {int *, unsigned int *};
%apply int *OUTPUT {int *, unsigned int *};
//%apply bool { TRUE, FALSE };

%typemap(jni) unsigned char *NIOBUFFER "jobject"  
%typemap(jtype) unsigned char *NIOBUFFER "java.nio.ByteBuffer"  
%typemap(jstype) unsigned char *NIOBUFFER "java.nio.ByteBuffer"  
%typemap(javain,
  pre="  assert $javainput.isDirect() : \"Buffer must be allocated direct.\";") unsigned char *NIOBUFFER "$javainput"
%typemap(javaout) unsigned char *NIOBUFFER {  
  return $jnicall;  
}  
%typemap(in) unsigned char *NIOBUFFER {  
  $1 = (unsigned char *) JCALL1(GetDirectBufferAddress, jenv, $input); 
  if ($1 == NULL) {  
    SWIG_JavaThrowException(jenv, SWIG_JavaRuntimeException, "Unable to get address of a java.nio.ByteBuffer direct byte buffer. Buffer must be a direct buffer and not a non-direct buffer.");  
  }  
}  
%typemap(memberin) unsigned char *NIOBUFFER {  
  if ($input) {  
    $1 = $input;  
  } else {  
    $1 = 0;  
  }  
}  
%typemap(freearg) unsigned char *NIOBUFFER ""  
%typemap(javadirectorin) unsigned char *NIOBUFFER "$jniinput"
%typemap(javadirectorout) unsigned char *NIOBUFFER "$javacall"



%typemap(in) T__UChar *  buffer {
  $1 = (T__UChar *)jenv->GetDirectBufferAddress($input);
  if ($1 == NULL) {
    SWIG_JavaThrowException(jenv, SWIG_JavaRuntimeException, "Unable to get address of direct buffer. Buffer must be allocated direct.");
  }
}
%typemap(jni) T__UChar *  buffer "jobject"
%typemap(jtype) T__UChar *  buffer "java.nio.ByteBuffer"
%typemap(jstype) T__UChar *  buffer "java.nio.ByteBuffer"
%typemap(javain) T__UChar *  buffer "$javainput"
%typemap(javaout) T__UChar *  buffer {
    return $jnicall;
}
%typemap(memberin) T__UChar *  buffer {
  if ($input) {
    $1 = $input;
  } else {
    $1 = 0;
  }
}
%typemap(freearg) T__UChar *  buffer {
	void *buffer = jenv->GetDirectBufferAddress($input);

    jenv->DeleteGlobalRef($input);
    free(buffer);
}
%typemap(directorin, descriptor="Ljava/nio/ByteBuffer;") T__UChar *  buffer {
jobject directBuffer = jenv->NewDirectByteBuffer((void*)buffer, (jsize)(width*height));
jobject globalRef = jenv->NewGlobalRef(directBuffer);
$input = globalRef;
}
%typemap(directorout) T__UChar *  buffer {
$1 = 0;
if($input){
$result = (T__UChar *)jenv->GetDirectBufferAddress($input);
if(!$1)
return $null;
}
}
%typemap(javadirectorin) T__UChar *  buffer "$jniinput"
%typemap(javadirectorout) T__UChar *  buffer "$javacall"



// BDS_Image buffer


%typemap(in) T__UChar *  buffer1 {
  $1 = (T__UChar *)jenv->GetDirectBufferAddress($input);
  if ($1 == NULL) {
    SWIG_JavaThrowException(jenv, SWIG_JavaRuntimeException, "Unable to get address of direct buffer. Buffer must be allocated direct.");
  }
}
%typemap(jni) T__UChar *  buffer1 "jobject"
%typemap(jtype) T__UChar *  buffer1 "java.nio.ByteBuffer"
%typemap(jstype) T__UChar *  buffer1 "java.nio.ByteBuffer"
%typemap(javain) T__UChar *  buffer1 "$javainput"
%typemap(javaout) T__UChar *  buffer1 {
    return $jnicall;
}
%typemap(memberin) T__UChar *  buffer1 {
  if ($input) {
    $1 = $input;
  } else {
    $1 = 0;
  }
}
%typemap(freearg) T__UChar *  buffer1 {
	void *buffer = jenv->GetDirectBufferAddress($input);

    jenv->DeleteGlobalRef($input);
    free(buffer);
}
%typemap(out, descriptor="Ljava/nio/ByteBuffer;") T__UChar *  buffer1 {
jobject directBuffer = jenv->NewDirectByteBuffer((void*)$1, (jsize)(((arg1)->m_width)*((arg1)->m_height)));
$result  = jenv->NewGlobalRef(directBuffer);
}
/*%typemap(out) T__UChar *  buffer1 {
$1 = 0;
if($input){
$result = (T__UChar *)jenv->GetDirectBufferAddress($input);
if(!$1)
return $null;
}
}*/




/*typemaps for unsigned char *BYTE  to  byte[]*/

%typemap(jni) T__UChar *  IO_DATA "jbyteArray"
%typemap(jtype) T__UChar *  IO_DATA "byte[]"
%typemap(jstype) T__UChar *  IO_DATA "byte[]"
%typemap(in) T__UChar *  IO_DATA {
  $1 = (unsigned char *) JCALL2(GetByteArrayElements, jenv, $input, 0); 
}
%typemap(argout) T__UChar *  IO_DATA  {
  JCALL3(ReleaseByteArrayElements, jenv, $input, (jbyte *) $1, 0); 
}
%typemap(javain) T__UChar *  IO_DATA "$javainput"

/* Prevent default freearg typemap from being used */
%typemap(freearg) T__UChar *  IO_DATA ""
%typemap(javaout) T__UChar *  IO_DATA {
  return $jnicall;
}

/*Director specific typemaps*/
%typemap(directorin, descriptor="[B") T__UChar *  IO_DATA {
jbyteArray jb = (jenv)->NewByteArray((jsize)(64));
(jenv)->SetByteArrayRegion(jb, 0, (jsize)(64), (jbyte*)$1);
$input = jb;
}
%typemap(directorout) T__UChar *  IO_DATA {
$1 = 0;
if($input){
$result = (char *) jenv->GetByteArrayElements($input, 0);
if(!$1)
return $null;
}
}
%typemap(javadirectorin) T__UChar *  IO_DATA "$jniinput"
%typemap(javadirectorout) T__UChar *  IO_DATA "$javacall"





%ignore BDS_BlindData;
%ignore BDS_resolveInterface;


%pragma(java) jniclassimports=%{
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
%}

%pragma(java) jniclasscode=%{
  static {
    InputStream input = null;
    try {
    	Properties prop = new Properties();
    	System.loadLibrary("gnustl_shared");
    	System.loadLibrary("CommonLib");
    	input = new FileInputStream("/sdcard/MTOP/java/config.properties");
        
		// load a properties file
		prop.load(input);
 
		// get the property value and print it out
		String value = prop.getProperty("COM_USB_TYPE");
		if(value.equals("VIRTUAL"))
		{
			System.loadLibrary("ComUSB_Virtual");
		}
		System.loadLibrary("ComUSB");
		System.loadLibrary("SDKServices");
        System.loadLibrary("SDKServicesJNI");
    } catch (UnsatisfiedLinkError e) {
      System.err.println("Native code library failed to load. \n" + e);
      System.exit(1);
    } catch (IOException ex) {
		ex.printStackTrace();
	} finally {
		if (input != null) {
			try {
				input.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
  }
%}