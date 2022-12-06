
String getCategoryUrlSegment(String key){
  if(key == "voice_consultations"){
    return "voiceConsultations";
  }else if(key == "video_consultations"){
    return "videoConsultations";
  }else if(key == "chat_consultations"){
    return "chatConsultations";
  }else if(key == "emergency_consultations"){
    return "emergencyConsultations";
  }else if(key == "appointment_consultations"){
    return "appointmentConsultations";
  }else if(key == "faqs"){
    return "faqs";
  }else{
    return "voiceConsultations";
  }
}

String getIAPType(String type){
  if(type == "books"){
    return "book_sales";
  }else if(type == "onlineCourses"){
    return "online_course_attendances";
  }else if(type == "offlineCourses"){
    return "offline_course_attendances";
  }else{
    return "consultation";
  }
}

String getIconPath(String key){
  if(key == "voice_consultations"){
    return "assets/icons/audio_consultation.svg";
  }else if(key == "video_consultations"){
    return "assets/icons/video.svg";
  }else if(key == "chat_consultations"){
    return "assets/icons/chat.svg";
  }else if(key == "emergency_consultations"){
    return "assets/icons/emergency_consultation.svg";
  }else if(key == "appointment_consultations"){
    return "assets/icons/clinic.svg";
  }else if(key == "faqs"){
    return "assets/icons/question.svg";
  }else if(key == "onlineCourses"){
    return "assets/icons/online-course.svg";
  }else if(key == "offlineCourses"){
    return "assets/icons/recordedcourse.svg";
  }else{
    return "voiceConsultations";
  }
}

int getCategoryIndex(String key){
  if(key == "voice_consultations"){
    return 1;
  }else if(key == "video_consultations"){
    return 0;
  }else if(key == "chatConsultations" || key == "chat_consultations"){
    return 2;
  }else if(key == "onlineCourses"){
    return 3;
  }else if(key == "offlineCourses"){
    return 4;
  }else if(key == "books"){
    return 5;
  }else if(key == "emergencyConsultations" || key == "emergency_consultations"){
    return 8;
  }else if(key == "appointmentConsultations" || key == "appointment_consultations"){
    return 7;
  }else if(key == "faqs"){
    return 6;
  }else{
    return 0;
  }
}

int getLecturerWaitingCategoryIndex(String key){
  if(key == "emergencyConsultations" || key == "emergency_consultations"){
    return 0;
  }else if(key == "video_consultations"){
    return 1;
  }else if(key == "voice_consultations"){
    return 2;
  }else if(key == "chatConsultations" || key == "chat_consultations"){
    return 3;
  }else if(key == "faqs"){
    return 4;
  }else if(key == "appointmentConsultations" || key == "appointment_consultations"){
    return 5;
  }else{
    return 0;
  }
}

String getVideoID(String url){
  if(url.contains("watch")){
    return url.substring(url.indexOf("=") + 1);
  }else if (url.contains("youtu.be")){
    return url.substring(url.lastIndexOf("/") + 1);
  }else{
    return "";
  }
}
