import 'package:flutter/material.dart';

class TermsPoliciesScreen extends StatelessWidget {
  const TermsPoliciesScreen({super.key});

  final List<Map<String, String>> termsSections = const [
    {
      'title': '1. 서비스 이용',
      'content': '본 앱을 사용함으로써 귀하는 모든 관련 법률 및 규정을 준수하는 데 동의합니다. 불법적이거나 승인되지 않은 목적으로 앱을 사용해서는 안 됩니다. 당사는 본 약관을 위반하는 경우 귀하의 앱 접근 권한을 일시 중단하거나 종료할 권리를 보유합니다.',
    },
    {
      'title': '2. 개인정보 처리방침',
      'content': '당사는 귀하의 개인정보를 존중하며 보호하기 위해 최선을 다합니다. 수집된 모든 정보는 당사 개인정보 처리방침에 따라 사용되며, 법률에 의해 요구되는 경우를 제외하고 귀하의 동의 없이 제3자와 공유되지 않습니다.',
    },
    {
      'title': '3. 결제 약관',
      'content': '앱을 통한 모든 결제는 당사의 신뢰할 수 있는 결제 파트너를 통해 안전하게 처리됩니다. 비자, 직불 카드, 착불 결제가 가능합니다. 결제 확인은 이메일 또는 앱 알림을 통해 전송됩니다. 귀하는 정확한 결제 정보를 제공할 책임이 있습니다.',
    },
    {
      'title': '4. 사용자 책임',
      'content': '귀하는 본인의 계정 자격 증명에 대한 기밀 유지 책임이 있습니다. 귀하는 타인과 계정 정보를 공유하지 않을 것에 동의합니다. 계정에서 발생하는 모든 활동에 대한 책임은 귀하에게 있습니다. 주문 시 정확한 정보를 제공해야 합니다.',
    },
    {
      'title': '5. 배송 조건',
      'content': '제공된 배송 시간은 예상 시간이며 날씨, 교통 상황 또는 운영 지연과 같은 예상치 못한 상황으로 인해 달라질 수 있습니다. 당사는 주문하신 상품을 정시에 배송하기 위해 최선을 다하지만 배송 지연에 대해서는 책임을 지지 않습니다.',
    },
    {
      'title': '6. 환불 정책',
      'content': '환불은 사례별로 처리됩니다. 주문 상품에 결함이 있거나 오배송된 경우 48시간 이내에 고객 지원팀에 문의해 주십시오. 환불 승인 및 처리에는 최대 7영업일이 소요될 수 있습니다.',
    },
    {
      'title': '7. 지적 재산권',
      'content': '앱에 표시된 모든 콘텐츠, 이미지, 상표 및 로고는 나라온 앱 또는 라이선스 제공자의 자산입니다. 사전 서면 허가 없이 콘텐츠를 복제, 배포 또는 사용하지 않을 것에 동의합니다.',
    },
    {
      'title': '8. 책임 제한',
      'content': '나라온 앱은 앱 사용으로 인해 발생하는 간접적, 부수적 또는 결과적 손해에 대해 책임을 지지 않습니다. 당사는 앱의 원활한 접속 또는 오류 없는 성능을 보장하지 않습니다.',
    },
    {
      'title': '9. 약관 변경',
      'content': '당사는 언제든지 본 약관을 업데이트하거나 수정할 권리가 있습니다. 중요한 변경 사항은 앱 또는 이메일을 통해 사용자에게 공지됩니다. 앱을 계속 사용하는 것은 업데이트된 약관에 동의하는 것으로 간주됩니다.',
    },
    {
      'title': '10. 준거법',
      'content': '본 약관은 나라온 앱이 운영되는 관할권의 법률에 따라 적용되고 해석됩니다. 발생하는 모든 분쟁은 해당 관할권 법원의 전속 관할권에 따릅니다.',
    },
    {
      'title': '알림',
      'content': '모든 약관을 주의 깊게 읽어주시기 바랍니다. 문의 사항이 있으시면 지원팀에 문의해 주십시오.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('약관 및 정책')),
      body: Scrollbar(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: termsSections.length,
          separatorBuilder: (_, __) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            final section = termsSections[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  section['title']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  section['content']!,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: Colors.black87,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
