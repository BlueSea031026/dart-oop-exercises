import 'package:flutter/material.dart';


class SanPham {
  String ten;
  String moTa;
  double gia;
  String hinhAnh;

  SanPham(this.ten, this.moTa, this.gia, this.hinhAnh);
}

List<SanPham> danhSachSanPham = [
  SanPham('Điện thoại 01', 'Điện thoại mới của hãng Samsung với công nghệ hiện đại', 1200.0, 'assets/images/oppo.jpg'),
  SanPham('Điện thoại 02', 'Điện thoại mới của hãng Apple với công nghệ hiện đại', 999.0, 'assets/images/ip17.jpg'),
  SanPham('Điện thoại 03', 'Điện thoại mới của hãng Oppo với công nghệ hiện đại', 450.0, 'assets/images/ipduo.jpg'),
  SanPham('Điện thoại 04', 'Điện thoại mới của hãng Xiaomi với công nghệ hiện đại', 602.2, 'assets/images/oneplus15.jpg'),
  SanPham('Điện thoại 05', 'Điện thoại mới của hãng Vivo với công nghệ hiện đại', 320.0, 'assets/images/oppo.jpg'),
  SanPham('Điện thoại 06', 'Điện thoại mới của hãng Realme với công nghệ hiện đại', 280.0, 'assets/images/ipduo.jpg'),
  SanPham('Điện thoại 07', 'Điện thoại mới của hãng Nokia với công nghệ hiện đại', 2000.0, 'assets/images/ip17.jpg'),
];

List<SanPham> gioHang = [];


class TrangGioiThieu extends StatelessWidget {
  const TrangGioiThieu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/huit.jpg', width: 130, height: 130),
                const SizedBox(height: 20),
                const Text(
                  'Cửa hàng điện thoại',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  '140 Lê Trọng Tấn, Tân Phú, TP.Hồ Chí Minh',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 30),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TrangChu()),
                    );
                  },
                  child: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


Widget taoDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: Colors.blue, 
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
       
        UserAccountsDrawerHeader(
          decoration: const BoxDecoration(color: Colors.white),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: ClipOval(
              child: Image.asset('assets/images/huit.jpg',
                  width: 60, height: 60, fit: BoxFit.cover),
            ),
          ),
          accountName: const Text('Vũ Văn Vinh',
              style: TextStyle(color: Colors.black87)),
          accountEmail: const Text('vinhvv@huit.edu.vn',
              style: TextStyle(color: Colors.black54)),
        ),
        ListTile(
          leading: const Icon(Icons.store, color: Colors.black87),
          title: const Text('Cửa hàng'),
          onTap: () {
            Navigator.pop(context); 
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TrangChu()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.shopping_cart, color: Colors.black87),
          title: const Text('Giỏ hàng'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TrangGioHang()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app, color: Colors.black87),
          title: const Text('Thoát'),
          onTap: () {

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const TrangGioiThieu()),
              (route) => false,
            );
          },
        ),
      ],
    ),
  );
}


class TrangChu extends StatefulWidget {
  const TrangChu({super.key});

  @override
  State<TrangChu> createState() => _TrangChuState();
}

class _TrangChuState extends State<TrangChu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cửa hàng điện thoại'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TrangGioHang()),
              );
            },
          ),
        ],
      ),
      drawer: taoDrawer(context),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Center(
              child: Text(
                'Chọn sản phẩm bạn muốn sử dụng',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          SizedBox(
            height: 330,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: danhSachSanPham.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 200,
                  child: oSanPham(danhSachSanPham[index]),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Text(
                'Sản phẩm được lựa chọn nhiều nhất',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget oSanPham(SanPham sp) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(right: 12, bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(sp.hinhAnh, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 10),
            Text(sp.ten,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 6),
            Text(
              sp.moTa,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Row(
              children: [

                Text(sp.gia.toString(), style: const TextStyle(fontSize: 13)),
                const Spacer(),

                SizedBox(
                  width: 36,
                  height: 36,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => xacNhanThem(sp),
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void xacNhanThem(SanPham sp) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xác nhận'),
          content: const Text('Bạn vừa thêm sản phẩm vào Giỏ hàng'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Không'),
            ),
            TextButton(
              onPressed: () {
                gioHang.add(sp);
                Navigator.pop(context);
              },
              child: const Text('Đồng ý'),
            ),
          ],
        );
      },
    );
  }
}


class TrangGioHang extends StatefulWidget {
  const TrangGioHang({super.key});

  @override
  State<TrangGioHang> createState() => _TrangGioHangState();
}

class _TrangGioHangState extends State<TrangGioHang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Giỏ hàng của bạn')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text('Giỏ hàng của bạn', style: TextStyle(fontSize: 13)),
            ),
          ),
          Expanded(
            child: gioHang.isEmpty
                ? const Center(
                    child: Text('Bạn chưa có sản phẩm nào trong giỏ hàng'),
                  )
                : ListView.builder(
                    itemCount: gioHang.length,
                    itemBuilder: (context, index) {
                      SanPham sp = gioHang[index];
                      return ListTile(
                        title: Text(sp.ten),
                        subtitle: Text(sp.gia.toString()),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.black87),
                          onPressed: () => xacNhanXoa(index),
                        ),
                      );
                    },
                  ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.teal,
                shape: const StadiumBorder(),
              ),
              onPressed: thanhToan,
              child: const Text('Thanh toán'),
            ),
          ),
        ],
      ),
    );
  }


  void xacNhanXoa(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xác nhận'),
          content: const Text('Bạn muốn loại bỏ sản phẩm này ra khỏi giỏ hàng'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Không'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  gioHang.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: const Text('Đồng ý'),
            ),
          ],
        );
      },
    );
  }

  void thanhToan() {
    if (gioHang.isEmpty) return; 
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Thanh toán'),
          content: Text('Bạn đã thanh toán xong giỏ hàng'),
        );
      },
    ).then((_) {
      setState(() {
        gioHang.clear();
      });
    });
  }
}