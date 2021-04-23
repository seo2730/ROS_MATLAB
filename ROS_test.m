%% Connect ROS Through Wifi
% ros UDP 접속을 위한 상대 companion computer ip
rosinit('192.168.0.34');

% rossshutdown
%% Publisher
% rospublisher( node , topicname )
pub = rospublisher('/state','std_msgs/Float32');
command = rospublisher('attitude_command','geometry_msgs/Quaternion');

% send data (message를 만들어서 데이터를 보냄)
msg = rosmessage(pub);
msg.Data = 1;
% 한 번 보낼 때
send(pub,msg); 

% 여러 번 보낼 때
for i=1:100
    msg.Data = i;
    send(pub,msg);
end

%% Subscriber -> Chek your Ubuntu ~/.bashrc ROS_MATSER_URI & ROS_HOSTNAME -> DO not use hostname:11311
% rossubscriber (node, topic, callback)
sub = rossubscriber('/state','std_msgs/Float32',@sub_test_callback);
% sub.NewMessageFcn = @sub_test_callback;
% sub = rossubscriber('/state','std_msgs/Float32');

% get data
msg2 = receive(sub,10);

function sub_test_callback(src,msg2)
    disp(msg2.Data)
end