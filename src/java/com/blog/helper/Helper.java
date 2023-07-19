
package com.blog.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

public class Helper {
       public static boolean deleteFile (String path) {
              boolean flag = false;
              try {
                     File file = new File (path);
                     file.delete();
                     flag = true;
              } catch (Exception e) {
                     e.printStackTrace();
              }
              
              return flag;
       }
       
       public static boolean savePicture (InputStream is, String path) {
              boolean flag = false;
              try {
                     byte[] b = new byte[is.available()];
                     is.read(b);
                     
                     FileOutputStream fos = new FileOutputStream(path);
                     fos.write(b);
                     
                     fos.flush();
                     fos.close();
                     flag = true;
              } 
              catch (Exception e) {
                     e.printStackTrace();
              }
              
              return flag;
       }
       
}