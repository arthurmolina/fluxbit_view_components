---
label: Range
title: Fluxbit::Form::RangeComponent or fx_range
---

The `Fluxbit::Form::RangeComponent` is a flexible range slider component that extends `Fluxbit::Form::FieldComponent`.
It provides customizable range sliders for selecting numeric values within a specified range, with support for horizontal and vertical orientations, different sizes, labels, helper text, and full compatibility with Rails form builders.

**Attention: This component isn't used alone. It is used with the other form components.**

To start using the range you can use the default way to call the component:

```html
&lt;%= render Fluxbit::Form::RangeComponent.new(name: "volume", label: "Volume") %&gt;

&lt;!-- or --&gt;

&lt;%= render Fluxbit::Form::RangeComponent.new(name: "volume", label: "Volume") do %&gt;
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_range(name: "volume", label: "Volume") %&gt;

&lt;!-- or --&gt;

&lt;%= fx_range(name: "volume", label: "Volume") do %&gt;
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::RangeComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param              | Default  | Description
|:-------------------|:---------|:------------
| name:              |          | Field name (required unless using a form builder)
| label:             |          | Text label above the field
| value:             |          | Current value for the range input
| min:               | 0        | Minimum value for the range slider
| max:               | 100      | Maximum value for the range slider
| step:              | 1        | Step increment for the slider
| vertical:          | false    | Renders the slider vertically if true
| sizing:            | 1        | Size index for slider thickness (0 to &lt;%= Fluxbit::Config::Form::RangeComponent.styles[:sizes].count - 1 %&gt;)
| help_text:         |          | Help or error text below the field
| helper_popover:    |          | Content for a popover helper
| helper_popover_placement: | "right" | Placement of the popover (`:top`, `:right`, `:bottom`, `:left`)
| disabled:          | false    | Disables the input if true
| required:          | false    | Marks the field as required
| remove_class:      | ""       | Classes to be removed from the default class list
| wrapper_html:      | {}       | Additional HTML attributes for the wrapper div
| **props            |          | Additional HTML attributes for the input element

## Slots

This component does not define any named slots. The range slider content is determined by the min, max, value, and step parameters.

## Examples

### Basic range slider

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::RangeComponentPreview" scenario="basic_range" panels="source"></lookbook-embed>

### Range slider sizes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::RangeComponentPreview" scenario="range_sizes" panels="source"></lookbook-embed>

### Range with custom min/max/step

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::RangeComponentPreview" scenario="custom_range_values" panels="source"></lookbook-embed>

### Vertical range slider

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::RangeComponentPreview" scenario="vertical_range" panels="source"></lookbook-embed>

### Range with helper text

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::RangeComponentPreview" scenario="with_helper_text" panels="source"></lookbook-embed>

### Range with helper popover

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::RangeComponentPreview" scenario="with_helper_popover" panels="source"></lookbook-embed>

### Disabled range slider

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::RangeComponentPreview" scenario="disabled_range" panels="source"></lookbook-embed>

### Required vs optional fields

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::RangeComponentPreview" scenario="required_field" panels="source"></lookbook-embed>

### Range for different use cases

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::RangeComponentPreview" scenario="use_cases" panels="source"></lookbook-embed>

### Range with form builder

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::RangeComponentPreview" scenario="with_form_builder" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::RangeComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::RangeComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## When to use

Use `Range` for:
- **Volume controls**: Audio/video volume adjustment sliders
- **Brightness/opacity**: Display settings and image editing controls
- **Price ranges**: Budget selectors and pricing filters
- **Quantity selection**: Product quantities and serving sizes
- **Rating systems**: User rating and scoring interfaces
- **Progress indicators**: Interactive progress bars and completion meters
- **Settings adjustment**: Sensitivity, speed, and preference controls
- **Data filtering**: Range-based filters for dates, numbers, and values

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
      rating: "Product Rating"
      volume: "Volume Level"
      brightness: "Brightness"
    help_text:
      rating: "Rate this product from 1 to 5 stars"
      volume: "Adjust the volume from 0 to 100"
      brightness: "Set the display brightness level"
    helper_popover:
      rating: "Your rating helps other customers make informed decisions"

# In your form
&lt;%= fx_range(form: form, attribute: :rating, min: 1, max: 5) %&gt;
# Automatically uses labels and help text from translations

# Override with custom values
&lt;%= fx_range(form: form, attribute: :rating, label: "Custom Label") %&gt;

# Disable automatic labels/help text
&lt;%= fx_range(form: form, attribute: :rating, label: false, help_text: false) %&gt;
```

### Override Behavior

- **Custom value**: Pass a string to override the translation
- **Disable**: Pass `false` to disable automatic translation lookup
- **Default**: Leave blank to use automatic translation lookup

## Range Sizes

- **`0`**: Thin slider (`h-1 range-sm`) for compact interfaces
- **`1`**: Medium slider (`h-2`) - default size
- **`2`**: Thick slider (`h-3 range-lg`) for emphasis and accessibility

## Orientation Options

- **Horizontal** (default): Standard left-to-right slider for most use cases
- **Vertical**: Top-to-bottom slider, useful for volume controls and space-constrained layouts

## Accessibility

* Uses semantic `<input type="range">` element for proper screen reader support
* Supports keyboard navigation (arrow keys, Page Up/Down, Home/End)
* Labels are properly associated with range inputs using `for` attribute
* ARIA attributes can be added via props for enhanced accessibility
* Min, max, and step values are announced by screen readers
* Current value changes are announced to assistive technologies
* Supports all standard HTML attributes for enhanced accessibility

## Best Practices

- Always provide clear labels indicating what the range controls
- Set appropriate min, max, and step values for the use case
- Consider adding helper text to explain the range values or units
- Use consistent step increments that make sense for your data
- Provide visual feedback for the current value when helpful
- Test with keyboard navigation to ensure accessibility
- Consider using helper popovers for complex range explanations

## Form Integration

The Range component integrates seamlessly with Rails form builders:

```html
&lt;%= form_with model: @user do |form| %&gt;
  &lt;%= fx_range(form: form, attribute: :age, label: "Age", min: 18, max: 100) %&gt;
&lt;% end %&gt;
```

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_range_component_defaults.rb

Fluxbit::Config::Form::RangeComponent.vertical = true # the default is false
Fluxbit::Config::Form::RangeComponent.sizing = 2 # the default is 1
Fluxbit::Config::Form::RangeComponent.styles[:base] = 'w-full bg-blue-200 rounded-lg appearance-none cursor-pointer dark:bg-blue-700' # custom colors
Fluxbit::Config::Form::RangeComponent.styles[:sizes] = ["h-1", "h-2", "h-4", "h-6"] # add more size options
```

## Dependencies

- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.
- [**Fluxbit::Form::LabelComponent**](Label.md): Used for rendering field labels.
- [**Fluxbit::Form::HelpTextComponent**](HelpText.md): Used for rendering help text messages.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::Form::RangeComponent.styles)) %>
```

## References

[Flowbite Range Slider](https://flowbite.com/docs/forms/range/)