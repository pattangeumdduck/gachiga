import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'care_detail_screen.dart';

class CareScreen extends StatefulWidget {
  const CareScreen({Key? key}) : super(key: key);

  @override
  _CareScreenState createState() => _CareScreenState();
}

class _CareScreenState extends State<CareScreen> {
  // 회원 유형: 'senior'이면 시니어 회원은 본인을 올린 주니어 회원의 리스트를, 'junior'이면 반대로 표시합니다.
  String userType = 'senior';

  // 10개의 더미 데이터 생성 (userType이 'senior'이면 보일 수 있도록 모두 'junior'로 설정)
  List<Map<String, dynamic>> careItems = List.generate(10, (index) {
    return {
      'id': index + 1,
      'profileImageUrl': null,
      'description': '더미 아이템 ${index + 1}',
      'survey': '설문 내용 예시 ${index + 1}',
      'category': '전체',
      'postedBy': 'junior',
    };
  });

  String selectedCategory = '전체';

  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _showAddCareModal() {
    _descriptionController.clear();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '리스트 등록',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: '간단한 설명',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('취소'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_descriptionController.text.isNotEmpty) {
                        setState(() {
                          careItems.add({
                            'id': careItems.length + 1,
                            'profileImageUrl': null,
                            'description': _descriptionController.text,
                            'survey': '가입 시 작성한 설문조사 예시',
                            'category': selectedCategory,
                            'postedBy': userType == 'senior' ? 'junior' : 'senior',
                          });
                        });
                        Navigator.pop(context);
                      } else {
                        Get.snackbar('오류', '설명을 입력해주세요');
                      }
                    },
                    child: const Text('등록하기'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // 필터링: userType이 senior이면 postedBy가 junior인 항목만, junior이면 반대로 필터링
  List<Map<String, dynamic>> get filteredCareItems {
    return careItems.where((item) {
      bool correctUserType = userType == 'senior'
          ? item['postedBy'] == 'junior'
          : item['postedBy'] == 'senior';
      bool correctCategory = selectedCategory == '전체'
          ? true
          : item['category'] == selectedCategory;
      return correctUserType && correctCategory;
    }).toList();
  }

  Widget _buildCategoryBar() {
    List<String> categories = ['전체', 'A', 'B', 'C'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((cat) {
          bool isSelected = cat == selectedCategory;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ChoiceChip(
              label: Text(cat),
              selected: isSelected,
              onSelected: (_) {
                setState(() {
                  selectedCategory = cat;
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCareListItem(Map<String, dynamic> item) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[300],
        backgroundImage: item['profileImageUrl'] != null
            ? NetworkImage(item['profileImageUrl'])
            : null,
        child: item['profileImageUrl'] == null
            ? const Icon(Icons.person)
            : null,
      ),
      title: Text(item['description']),
      onTap: () {
        Get.to(() => CareDetailScreen(careItem: item));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 앱 바 제거됨
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildCategoryBar(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCareItems.length,
              itemBuilder: (context, index) {
                return _buildCareListItem(filteredCareItems[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCareModal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
