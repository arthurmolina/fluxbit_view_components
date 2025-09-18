---
label: Dropzone
title: Fluxbit::Form::DropzoneComponent or fx_dropzone
---

The `Fluxbit::Form::DropzoneComponent` is a drag-and-drop file input component that extends `Fluxbit::Form::FieldComponent`.
It provides a visually rich file upload area that allows users to either drag and drop files or click to select files. The component supports customizable titles, subtitles, icons, different height presets, and integrates seamlessly with Rails form builders.

To start using the dropzone you can use the default way to call the component:

```html
&lt;%= render Fluxbit::Form::DropzoneComponent.new(name: "avatar").with_content('') %&gt;

&lt;!-- or --&gt;

&lt;%= render Fluxbit::Form::DropzoneComponent.new(name: "avatar") do %&gt;
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_dropzone(name: "avatar") %&gt;

&lt;!-- or --&gt;

&lt;%= fx_dropzone(name: "avatar") do %&gt;
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::DropzoneComponentPreview" scenario="playground" panels="params,source"></lookbook-embed>

## Options

| Param              | Default                  | Description
|:-------------------|:-------------------------|:------------
| name:              |                          | Field name (required unless using a form builder)
| label:             |                          | Label text above the dropzone
| title:             | true                     | Title text inside dropzone (true for default, false to hide, or custom string)
| subtitle:          | true                     | Subtitle text below title (true for default, false to hide, or custom string)
| icon:              | :upload                  | Icon to display above the title (Anyicon name or symbol)
| icon_html:         | {}                       | Additional HTML attributes for the icon element
| height:            | 0                        | Height preset (0: auto, 1: h-32, 2: h-64, 3: h-96)
| help_text:         |                          | Help or error text below the field
| multiple:          | false                    | Allow multiple file selection
| accept:            |                          | Comma-separated list of accepted file types
| disabled:          | false                    | Disables the input if true
| remove_class:      | ""                       | Classes to be removed from the default class list
| **props            |                          | Additional HTML attributes for the file input element

## Slots

The component supports custom content via the default slot. When content is provided, it replaces the default icon, title, and subtitle:

```html
&lt;%= fx_dropzone(name: "custom_upload") do %&gt;
  &lt;div class="text-center"&gt;
    &lt;h3 class="text-lg font-bold"&gt;Custom Upload Area&lt;/h3&gt;
    &lt;p&gt;Drop your files here&lt;/p&gt;
  &lt;/div&gt;
&lt;% end %&gt;
```

## Examples

### Basic dropzone

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::DropzoneComponentPreview" scenario="basic_dropzone" panels="source"></lookbook-embed>

### Different heights

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::DropzoneComponentPreview" scenario="different_heights" panels="source"></lookbook-embed>

### Custom title and subtitle

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::DropzoneComponentPreview" scenario="custom_title_subtitle" panels="source"></lookbook-embed>

### Different icons

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::DropzoneComponentPreview" scenario="different_icons" panels="source"></lookbook-embed>

### Multiple file upload

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::DropzoneComponentPreview" scenario="multiple_files" panels="source"></lookbook-embed>

### File type restrictions

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::DropzoneComponentPreview" scenario="file_restrictions" panels="source"></lookbook-embed>

### With helper text

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::DropzoneComponentPreview" scenario="with_helper_text" panels="source"></lookbook-embed>

### Disabled state

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::DropzoneComponentPreview" scenario="disabled_dropzone" panels="source"></lookbook-embed>

### Custom content slot

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::DropzoneComponentPreview" scenario="custom_content" panels="source"></lookbook-embed>

### With form builder

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::DropzoneComponentPreview" scenario="with_form_builder" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::DropzoneComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::DropzoneComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## When to use

Use `Dropzone` for:
- **File uploads**: Any scenario requiring users to upload files
- **Profile pictures**: Avatar or image uploads with visual feedback
- **Document submission**: Forms requiring document attachments
- **Multiple file uploads**: Batch file processing scenarios
- **Drag-and-drop interfaces**: Enhanced UX for file selection
- **Media uploads**: Images, videos, or other media content

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
  product:
    fields:
      image: "Product Image"
      documents: "Supporting Documents"
    help_text:
      image: "Upload a high-quality product image (JPG, PNG, max 5MB)"
      documents: "Upload any supporting documents or manuals"
    helper_popover:
      image: "Choose a clear, well-lit image that showcases your product"

# In your form
&lt;%= fx_dropzone(form: form, attribute: :image) %&gt;
# Automatically uses labels and help text from translations

# Override with custom values
&lt;%= fx_dropzone(form: form, attribute: :image, label: "Custom Label") %&gt;

# Disable automatic labels/help text
&lt;%= fx_dropzone(form: form, attribute: :image, label: false, help_text: false) %&gt;
```

### Override Behavior

- **Custom value**: Pass a string to override the translation
- **Disable**: Pass `false` to disable automatic translation lookup
- **Default**: Leave blank to use automatic translation lookup

## Supported File Operations

- **Single file upload**: Default behavior for individual file selection
- **Multiple file upload**: Set `multiple: true` for batch uploads
- **File type filtering**: Use `accept` attribute to restrict file types
- **Drag and drop**: Native browser drag-and-drop support
- **Click to browse**: Fallback file browser for all devices

## Accessibility

* Uses proper `<label>` element for file input association
* File input remains accessible via keyboard navigation
* Support for `disabled` state with appropriate visual feedback
* Screen reader compatible with semantic HTML structure
* Accepts all standard file input attributes via props
* ARIA attributes can be added through the props parameter

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_dropzone_component_defaults.rb

Fluxbit::Config::Form::DropzoneComponent.icon = :cloud_upload # the default is :upload
Fluxbit::Config::Form::DropzoneComponent.height = 2 # the default is 0
Fluxbit::Config::Form::DropzoneComponent.styles[:base] = 'w-full border-2 border-dashed border-gray-300 rounded-lg' # modify base styles
Fluxbit::Config::Form::DropzoneComponent.styles[:height][4] = 'h-screen' # add custom height option
```

## Dependencies

- [**Anyicon**](https://github.com/arthurmolina/anyicon): Used for rendering upload icons.
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::Form::DropzoneComponent.styles)) %>
```

## References

[Flowbite File Upload](https://flowbite.com/docs/forms/file-input/)