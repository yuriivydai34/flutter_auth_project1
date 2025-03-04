import 'package:socket_io_client/socket_io_client.dart' as IO;

void initSocket() {
  IO.Socket socket;
  // Dart client
  socket = IO.io(
    'http://localhost:3000',
    IO.OptionBuilder().setTransports(['websocket']).build(),
  );
  socket.onConnect((_) {
    print('connect');
    socket.emit('chat message', 'test111');
  });
  socket.on('event', (data) => print(data));
  socket.onDisconnect((_) => print('disconnect'));
  socket.on('fromServer', (data) => print(data));
}