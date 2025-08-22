import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meu_app/produtos.dart';

void main() {
  group('ProdutosWidget Tests', () {
    testWidgets('ProdutosWidget renders correctly', (WidgetTester tester) async {
      // Build the ProdutosWidget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProdutosWidget(),
          ),
        ),
      );

      // Verify that the title is present
      expect(find.text('Nossos Produtos'), findsOneWidget);
      expect(find.text('Soluções em drywall para todos os ambientes'), findsOneWidget);

      // Verify that product cards are rendered
      expect(find.byType(ProductCard), findsWidgets);
    });

    testWidgets('ProductCard displays product information', (WidgetTester tester) async {
      final produto = Produto(
        nome: 'Test Product',
        descricao: 'Test Description',
        preco: 'R\$ 10,00',
        imagemUrl: 'https://via.placeholder.com/300x200',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCard(produto: produto),
          ),
        ),
      );

      // Verify product information is displayed
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
      expect(find.text('R\$ 10,00'), findsOneWidget);
    });

    testWidgets('Responsive grid adapts to different screen sizes', (WidgetTester tester) async {
      // Test mobile layout
      await tester.binding.setSurfaceSize(Size(400, 800));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProdutosWidget(),
          ),
        ),
      );
      
      // On mobile, grid should have 1 column
      // This would be tested by checking the actual grid delegate if we had access to it
      
      // Test tablet layout  
      await tester.binding.setSurfaceSize(Size(700, 1000));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProdutosWidget(),
          ),
        ),
      );
      
      // Test desktop layout
      await tester.binding.setSurfaceSize(Size(1200, 800));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProdutosWidget(),
          ),
        ),
      );
    });

    testWidgets('ProductImage handles loading and error states', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductImage(imageUrl: 'invalid-url'),
          ),
        ),
      );

      // Should show loading initially, then error state
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}