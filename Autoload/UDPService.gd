extends Node
class_name UDP_Service

enum SERVICE_TYPE {
	CLIENT,
	SERVER,
	NONE
};

var test_server_data = {
	"address": "127.0.0.1",
	"enet_port": 7171,
	"udp_port": 7272,
};


var udp_pinger_thread: Thread = null;
var mutex: Mutex = null;
var semaphore: Semaphore = null;

var udp_service = null;
var service_type = SERVICE_TYPE.NONE;

var is_running: bool = false;
var disable_udp_service: bool = false;

var ping_sent = false;

var PORT = 7272;
# Array with dictionary data
# Server dict = {address, port}

var servers_to_ping: Array = [test_server_data];

func _ready():
	mutex = Mutex.new();
	semaphore = Semaphore.new();

func create_server(port_to_listen):
	udp_service = UDPServer.new();
	udp_service.listen(port_to_listen);

func create_client(address, port_to_connect):
	udp_service = PacketPeerUDP.new();
	udp_service.connect_to_host(address, port_to_connect);
	pass;

func clean():
	udp_service = null;

func server_function(port_to_listen):
	create_server(port_to_listen);
	print("Starting server!!");
	while disable_udp_service != false:
		udp_service.poll();
		if udp_service.is_connection_available():
			var ping : PacketPeerUDP = udp_service.take_connection();
			var packet = ping.get_packet();
			
			print(packet.get_string_from_utf8());
			ping.put_packet("CAN_CONNECT".to_utf8());
			
	var _threadReturn = udp_pinger_thread.wait_to_finish();
	
func client_function():
	while disable_udp_service != false:
		semaphore.wait();
		
		mutex.lock();
		
		for i in range(0, servers_to_ping.size()):
			var server = servers_to_ping[i];
			create_client(server.address, server.port);
			
			var recived_ping = false;
			var is_packet_sent = false;
			
			while recived_ping != true:
				if !is_packet_sent:
					udp_service.put_packet("ASK_TO_JOIN".to_utf8());
					is_packet_sent = true;
					print('Packet sent');
				else:
					if(udp_service.get_available_packet_count() > 0):
						print(udp_service.get_packet().get_string_from_utf8());
						recived_ping = false;
						clean();

func fire_server():
	udp_pinger_thread = Thread.new();
	udp_pinger_thread.start(self, "server_function", PORT);

func fire_client():
	udp_pinger_thread = Thread.new();
	udp_pinger_thread.start(self, "server_function");

func release_semaphore():
	semaphore.post();
