---
label: HelpText
title: Fluxbit::Form::HelpTextComponent or fx_help_text
---

The `Fluxbit::Form::HelpTextComponent` is a simple helper text component that extends `Fluxbit::Form::Component`.
It provides styled text elements for displaying helper information, validation messages, and explanatory content below form fields. The component supports different color schemes to indicate various states like success, error, warning, and informational messages.

**Attention: This component isn't used alone. It is used with the other form components.**

To start using the help text you can use the default way to call the component:

```html
&lt;%= render Fluxbit::Form::HelpTextComponent.new.with_content('Your password must be at least 8 characters.') %&gt;

&lt;!-- or --&gt;

&lt;%= render Fluxbit::Form::HelpTextComponent.new do %&gt;
  Your password must be at least 8 characters.
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_help_text(with_content: 'Your password must be at least 8 characters.') %&gt;

&lt;!-- or --&gt;

&lt;%= fx_help_text do %&gt;
  Your password must be at least 8 characters.
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::HelpTextComponentPreview" scenario="playground" panels="params,source"></lookbook-embed>

## Options

| Param              | Default     | Description
|:-------------------|:------------|:------------
| color:             | :default    | Color scheme of the help text (`:default`, `:success`, `:danger`, `:info`, `:warning`)
| remove_class:      | ""          | Classes to be removed from the default class list
| **props            |             | Additional HTML attributes for the paragraph element

## Slots

This component does not define any named slots. The help text content is provided through the default block or `with_content` method:

```html
&lt;%= fx_help_text(color: :success) do %&gt;
  This is the help text content
&lt;% end %&gt;
```

## Examples

### Default help text

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::HelpTextComponentPreview" scenario="default_help_text" panels="source"></lookbook-embed>

### Different color states

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::HelpTextComponentPreview" scenario="color_states" panels="source"></lookbook-embed>

### Success messages

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::HelpTextComponentPreview" scenario="success_messages" panels="source"></lookbook-embed>

### Error messages

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::HelpTextComponentPreview" scenario="error_messages" panels="source"></lookbook-embed>

### Warning messages

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::HelpTextComponentPreview" scenario="warning_messages" panels="source"></lookbook-embed>

### Info messages

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::HelpTextComponentPreview" scenario="info_messages" panels="source"></lookbook-embed>

### Multi-line help text

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::HelpTextComponentPreview" scenario="multiline_text" panels="source"></lookbook-embed>

### Help text with form fields

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::HelpTextComponentPreview" scenario="with_form_fields" panels="source"></lookbook-embed>

### Rich content help text

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::HelpTextComponentPreview" scenario="rich_content" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::HelpTextComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::HelpTextComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## When to use

Use `HelpText` for:
- **Field instructions**: Explaining how to fill out a form field correctly
- **Validation feedback**: Displaying success, error, or warning messages
- **Format requirements**: Specifying password criteria, file formats, or data formats
- **Additional context**: Providing extra information about form fields
- **Error descriptions**: Detailed error messages for failed validations
- **Character limits**: Showing remaining characters or length requirements
- **Privacy notices**: Brief explanations about data usage

## Color Usage Guidelines

- **`:default`** (gray): General instructions and neutral information
- **`:success`** (green): Positive feedback, successful validations
- **`:danger`** (red): Error messages, validation failures, warnings about destructive actions
- **`:warning`** (yellow): Caution messages, non-critical issues
- **`:info`** (cyan): Additional information, tips, helpful context

## Accessibility

* Uses semantic `<p>` element for proper screen reader support
* Color-coded text maintains sufficient contrast ratios
* Can be associated with form fields using ARIA attributes
* Supports all standard HTML attributes for enhanced accessibility
* Works well with screen readers when used as field descriptions

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_help_text_component_defaults.rb

Fluxbit::Config::Form::HelpTextComponent.color = :info # the default is :default
Fluxbit::Config::Form::HelpTextComponent.styles[:base] = 'text-xs ' # the default is 'text-sm '
Fluxbit::Config::Form::HelpTextComponent.styles[:colors][:custom] = 'text-purple-600 dark:text-purple-400' # add custom color
```

## Dependencies

- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::Form::HelpTextComponent.styles)) %>
```

## References

[Flowbite Helper Text](https://flowbite.com/docs/forms/input-field/#helper-text)