

-define(MSG_HEAD_LEN,16).             %信息头信息长度
-define(CMD_LEN,16).                  %信息头命令码长度

-define(INT32,32).
-define(INT16,16).
-define(CHAR8,8).

-define(LOGIN_CMD_ID,10001).         %登录请求命令码
-define(WHOONLINE_CMD_ID,10002).      %查看在线请求命令码
-define(FNDONLINE_CMD_ID,10003).      %查看在线朋友请求命令码  
-define(CHAT_SEND_CMD_ID,10004).      %发送聊天信息请求命令码
-define(CHAT_REV_CMD_ID,10005).       %接收聊天信息请求命令码
-define(LOGIN_TIMES_CMD_ID,10006).    %查看登录次数请求命令码
-define(CHAT_TIMES_CMD_ID,10007).     %查看聊天次数请求命令码
-define(REGISTER_CMD_ID,10101).       %用户注册请求命令码

-define(SUCCEED,0).
-define(FALSE,1).



%%%%%%%%%%使用新的协议解析方式
-define(CMD_10001,[int32,string]).
-define(CMD_10002,[]).
-define(CMD_10003,[]).
-define(CMD_10004,[int32,string,int32,int16,string]).
-define(CMD_10005,int32,string,int16,string).
-define(CMD_10006,int32).
-define(CMD_10007,int32).
-define(CMD_10101,string,string).


