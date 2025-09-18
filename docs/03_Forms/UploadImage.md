---
label: UploadImage
title: Fluxbit::Form::UploadImageComponent or fx_upload_image
---

The `Fluxbit::Form::UploadImageComponent` is a stylized image upload component that extends `Fluxbit::Form::FieldComponent`.
It provides a responsive image upload field with live preview, drag-and-drop UI, support for both mobile and desktop layouts, labels, helper text, and seamless integration with Rails form builders and Active Storage attachments.

**Attention: This component isn't used alone. It is used with the other form components.**

To start using the upload image you can use the default way to call the component:

```html
&lt;%= render Fluxbit::Form::UploadImageComponent.new(name: "avatar", label: "Profile Photo") %&gt;

&lt;!-- or --&gt;

&lt;%= render Fluxbit::Form::UploadImageComponent.new(name: "avatar", label: "Profile Photo") do %&gt;
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_upload_image(name: "avatar", label: "Profile Photo") %&gt;

&lt;!-- or --&gt;

&lt;%= fx_upload_image(name: "avatar", label: "Profile Photo") do %&gt;
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::UploadImageComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param                         | Default  | Description
|:------------------------------|:---------|:------------
| name:                         |          | Field name (required unless using a form builder)
| label:                        |          | Text label above the field
| help_text:                    |          | Help or error text below the field
| helper_popover:               |          | Content for a popover helper
| helper_popover_placement:     | "right"  | Placement of the popover (`:top`, `:right`, `:bottom`, `:left`)
| image_path:                   |          | Path to the current image to display
| image_placeholder:            |          | Placeholder image path if no image is attached
| title:                        | "Change" | Button text (true for default, false to hide, or custom string)
| accept:                       |          | File types accepted (e.g., "image/*", ".jpg,.png")
| multiple:                     | false    | Allow multiple file selection
| disabled:                     | false    | Disables the input if true
| required:                     | false    | Marks the field as required
| remove_class:                 | ""       | Classes to be removed from the default class list
| wrapper_html:                 | {}       | Additional HTML attributes for the wrapper div
| **props                       |          | Additional HTML attributes for the file input element

## Slots

This component does not define any named slots. The upload functionality is handled through the file input and image preview elements.

## Examples

### Basic image upload

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::UploadImageComponentPreview" scenario="basic_upload" panels="source"></lookbook-embed>

### With custom title

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::UploadImageComponentPreview" scenario="custom_title" panels="source"></lookbook-embed>

### With existing image

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::UploadImageComponentPreview" scenario="with_existing_image" panels="source"></lookbook-embed>

### With placeholder image

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::UploadImageComponentPreview" scenario="with_placeholder" panels="source"></lookbook-embed>

### With helper text and popover

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::UploadImageComponentPreview" scenario="with_help" panels="source"></lookbook-embed>

### File type restrictions

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::UploadImageComponentPreview" scenario="file_restrictions" panels="source"></lookbook-embed>

### Multiple file upload

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::UploadImageComponentPreview" scenario="multiple_files" panels="source"></lookbook-embed>

### With form builder

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::UploadImageComponentPreview" scenario="with_form_builder" panels="source"></lookbook-embed>

### Profile photo examples

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::UploadImageComponentPreview" scenario="profile_examples" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::UploadImageComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::UploadImageComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## When to use

Use `UploadImage` for:
- **Profile photos**: User avatar and profile picture uploads
- **Product images**: E-commerce product photo uploads
- **Document uploads**: File attachments with image preview
- **Gallery uploads**: Multiple image uploads for galleries
- **Logo uploads**: Company or brand logo uploads
- **Background images**: Hero images and background uploads
- **Thumbnail creation**: Generating image thumbnails and previews
- **Social media**: Image uploads for posts and stories

## Internationalization (I18n)

Labels, help texts, and helper popovers can be automatically loaded from translation files. The component will look for translations using Rails' I18n system based on the form object and attribute names.

### Translation Structure

```yaml
en:
  model_name:
    fields:
      attribute_name: "Custom Label"
    help_text:
      attribute_name: "Custom help text"
    helper_popover:
      attribute_name: "Custom popover content"
```

### Usage Examples

```ruby
# Translation file (config/locales/en.yml)
en:
  user:
    fields:
      avatar: "Profile Photo"
      cover_image: "Cover Image"
      gallery: "Photo Gallery"
    help_text:
      avatar: "Upload a profile photo (recommended: 400x400 pixels)"
      cover_image: "Upload a cover image for your profile"
      gallery: "Upload multiple photos to your gallery"
    helper_popover:
      avatar: "Choose a clear, professional photo that represents you well"

# In your form
&lt;%= fx_upload_image(form: form, attribute: :avatar) %&gt;
# Automatically uses labels and help text from translations

# Override with custom values
&lt;%= fx_upload_image(form: form, attribute: :avatar, label: "Custom Label") %&gt;

# Disable automatic labels/help text
&lt;%= fx_upload_image(form: form, attribute: :avatar, label: false, help_text: false) %&gt;
```

### Override Behavior

- **Custom value**: Pass a string to override the translation
- **Disable**: Pass `false` to disable automatic translation lookup
- **Default**: Leave blank to use automatic translation lookup

## Responsive Design

The component provides different interfaces for mobile and desktop:
- **Mobile**: Compact horizontal layout with small circular preview and button
- **Desktop**: Large circular preview with hover overlay for upload action
- **Automatic switching**: Based on screen size using responsive classes

## Live Preview

- **Instant feedback**: Shows selected image immediately after selection
- **JavaScript integration**: Built-in `loadFile` function for preview updates
- **Memory management**: Automatic cleanup of object URLs to prevent memory leaks
- **Multiple preview sync**: Updates all preview instances simultaneously

## File Handling

- **Accept attribute**: Restrict file types using standard HTML file input patterns
- **Multiple files**: Support for selecting multiple images at once
- **File size**: Combine with frontend validation for size restrictions
- **Format support**: Works with all standard web image formats (JPEG, PNG, GIF, WebP)

## Active Storage Integration

The component seamlessly integrates with Rails Active Storage:
- **Attachment detection**: Automatically detects existing attachments
- **Variant generation**: Creates optimized preview variants (160x160 resize_to_fit)
- **Form builder support**: Works with Rails form helpers and model attributes
- **Validation**: Supports Active Storage validations and error handling

## Accessibility

* Uses proper `<label>` elements for file input association
* Includes screen reader text for context
* Keyboard accessible file input controls
* ARIA attributes for enhanced screen reader support
* Focus management for both mobile and desktop interfaces
* Semantic HTML structure for assistive technologies

## Best Practices

- Always provide clear labels explaining what type of image to upload
- Set appropriate `accept` attributes to filter file types
- Include helper text for file size limits and format requirements
- Use helper popovers for complex upload requirements
- Test on both mobile and desktop devices
- Consider image optimization and compression on the backend
- Provide fallback images or placeholders for better UX

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_upload_image_component_defaults.rb

# Note: This component doesn't have a separate config class
# Customization is done through component parameters and CSS classes
```

## Dependencies

- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Active Storage**](https://guides.rubyonrails.org/active_storage_overview.html): For file attachment handling (optional).
- [**Fluxbit::Form::LabelComponent**](Label.md): Used for rendering field labels.
- [**Fluxbit::Form::HelpTextComponent**](HelpText.md): Used for rendering help text messages.

## Browser Support

- **File API**: Modern browsers with File API support for preview functionality
- **Object URLs**: Browsers supporting `URL.createObjectURL()` for image previews
- **CSS Grid/Flexbox**: Modern layout support for responsive design
- **Progressive enhancement**: Graceful degradation for older browsers

## Styles

The component uses inline Tailwind classes for styling. Key style features include:
- Responsive layout with mobile and desktop variants
- Circular image preview with proper aspect ratio
- Hover effects and transitions for desktop interaction
- Focus states for accessibility compliance
- Shadow and border styling for visual hierarchy

## References

[MDN File Input](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/file)