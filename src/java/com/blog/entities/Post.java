
package com.blog.entities;

import java.util.Date;

public class Post {
       private int pid;
       private String ptitle;
       private String pcontent;
       private String ppic;
       private Date pdate;
       private int catid;
       private int uid;

       public int getPid() {
              return pid;
       }

       public void setPid(int pid) {
              this.pid = pid;
       }

       public String getPtitle() {
              return ptitle;
       }

       public void setPtitle(String ptitle) {
              this.ptitle = ptitle;
       }

       public String getPcontent() {
              return pcontent;
       }

       public void setPcontent(String pcontent) {
              this.pcontent = pcontent;
       }

       public String getPpic() {
              return ppic;
       }

       public void setPpic(String ppic) {
              this.ppic = ppic;
       }

       public Date getPdate() {
              return pdate;
       }

       public void setPdate(Date pdate) {
              this.pdate = pdate;
       }

       public int getCatid() {
              return catid;
       }

       public void setCatid(int catid) {
              this.catid = catid;
       }

       public int getUid() {
              return uid;
       }

       public void setUid(int uid) {
              this.uid = uid;
       }

       
       public Post() {
       }

       public Post(int pid, String ptitle, String pcontent, String ppic, Date pdate, int catid, int uid) {
              this.pid = pid;
              this.ptitle = ptitle;
              this.pcontent = pcontent;
              this.ppic = ppic;
              this.pdate = pdate;
              this.catid = catid;
              this.uid = uid;
       }

       public Post(String ptitle, String pcontent, String ppic, Date pdate, int catid, int uid) {
              this.ptitle = ptitle;
              this.pcontent = pcontent;
              this.ppic = ppic;
              this.pdate = pdate;
              this.catid = catid;
              this.uid = uid;
       }
       
}
