@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Orders'),
    ),
    body: FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchAllOrders(),
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          final orders = snapshot.data!;
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (BuildContext context, int index) {
              final order = orders[index];
              return ListTile(
                title: Text(order['name']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total: \$${order['total_amount']}'),
                    Text('Total Due: \$${order['total_due']}'),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ),
  );
}
