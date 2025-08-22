# ProdutosWidget - Responsive Product Showcase

## Overview
The ProdutosWidget is a responsive Flutter widget designed to showcase drywall products in a professional, grid-based layout that adapts seamlessly to different screen sizes.

## Features Implemented

### 1. Responsive Grid Layout
- **Mobile (<600px)**: 1 column layout for optimal mobile viewing
- **Tablet (600-899px)**: 2 column layout for better space utilization
- **Desktop (≥900px)**: 3 column layout for maximum content display

### 2. Enhanced Card Design
- **Material Design Cards**: Clean, modern card layout with rounded corners
- **Dynamic Shadows**: Cards have subtle shadows that intensify on hover
- **Hover Effects**: Smooth scale animation (1.02x) with enhanced shadow on hover
- **Professional Styling**: Consistent spacing, typography, and color scheme

### 3. Responsive Spacing and Padding
- **Adaptive Padding**: Horizontal padding scales from 16px (mobile) to 32px (desktop)
- **Grid Spacing**: Dynamic spacing between cards (12px mobile, 20px desktop)
- **Card Padding**: Internal card padding adapts to screen size

### 4. Advanced Image Handling
- **Loading States**: Circular progress indicator with optional progress percentage
- **Error Handling**: Graceful fallback with informative error message and icon
- **Network Images**: Support for remote images with proper error recovery
- **Responsive Images**: Images scale appropriately within cards

### 5. Responsive Typography
- **Title Text**: Scales from 24px (mobile) to 32px (desktop)
- **Subtitle Text**: Scales from 14px (mobile) to 18px (desktop)
- **Product Names**: Adaptive font sizes with proper line height
- **Descriptions**: Responsive text with ellipsis overflow handling

### 6. Loading States and Error Handling
- **Progressive Loading**: Visual feedback during image loading
- **Error Recovery**: Automatic error state with retry capability
- **Graceful Degradation**: Meaningful fallbacks when content fails to load

## Implementation Details

### Widget Structure
```
ProdutosWidget
├── Responsive Padding Container
├── Title Section
│   ├── Main Title (responsive typography)
│   └── Subtitle (responsive typography)
└── LayoutBuilder
    └── GridView (responsive columns)
        └── ProductCard[] (with hover effects)
            ├── ProductImage (with loading/error states)
            └── Product Info Section
                ├── Product Name
                ├── Description (ellipsis overflow)
                └── Price (styled)
```

### Responsive Breakpoints
- **Mobile**: < 600px width
- **Tablet**: 600px - 899px width  
- **Desktop**: ≥ 900px width

### Animation and Interactions
- **Hover Animation**: 200ms scale transform with easing
- **Shadow Transition**: Smooth shadow intensity changes
- **Loading Animation**: Rotating circular progress indicator

## Integration
The widget is integrated into the main landing page (`view.dart`) between the content section and services section, providing a natural flow in the user experience.

## Sample Data
The widget includes 6 sample drywall products:
1. Parede Drywall Residencial
2. Forro Drywall Decorativo  
3. Parede Drywall Comercial
4. Nicho Drywall
5. Estante Drywall
6. Painel TV Drywall

## Technical Features
- **StatefulWidget**: ProductCard uses state management for hover effects
- **AnimationController**: Smooth hover animations with proper disposal
- **MediaQuery**: Screen size detection for responsive behavior
- **LayoutBuilder**: Dynamic layout based on available space
- **Image.network**: Network image loading with comprehensive error handling
- **Mouse Events**: Hover detection for desktop interactions

## Performance Considerations
- **Efficient Rendering**: Uses GridView.builder for optimal performance
- **Animation Optimization**: Short-duration animations (200ms) for responsiveness
- **Memory Management**: Proper disposal of animation controllers
- **Lazy Loading**: Grid items rendered on-demand

This implementation provides a professional, modern product showcase that enhances the user experience across all device types while maintaining excellent performance and accessibility.