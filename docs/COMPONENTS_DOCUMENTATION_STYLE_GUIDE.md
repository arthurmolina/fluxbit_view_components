# Component Documentation Style Guide - Fluxbit View Components

This document outlines the documentation standards, formatting conventions, and content structure guidelines for documenting components in the Fluxbit View Components gem.

## Table of Contents

1. [File Structure and Organization](#file-structure-and-organization)
2. [Document Structure](#document-structure)
3. [Front Matter Requirements](#front-matter-requirements)
4. [Content Sections](#content-sections)
5. [Code Examples and Formatting](#code-examples-and-formatting)
6. [Lookbook Integration](#lookbook-integration)
7. [Tables and Parameters](#tables-and-parameters)
8. [Writing Style Guidelines](#writing-style-guidelines)
9. [Template and Examples](#template-and-examples)

## File Structure and Organization

### Directory Structure

```
docs/
├── 02_Components/           # UI Components
│   ├── Button.md
│   ├── Modal.md
│   ├── Badge.md
│   └── Alert.md
├── 03_Forms/               # Form Components
│   └── TextField.md
└── 04_Typography/          # Typography Components
    ├── Heading.md
    └── Text.md
```

### File Naming Convention

- Use **PascalCase** for component documentation files
- Match the component class name without "Component" suffix
- Example: `Fluxbit::ButtonComponent` → `Button.md`
- Example: `Fluxbit::Form::TextFieldComponent` → `TextField.md`

## Document Structure

Every component documentation file must follow this exact structure:

1. **Front Matter** (YAML metadata)
2. **Component Description** (Opening paragraph)
3. **Basic Usage Examples** (Component and helper syntax)
4. **Interactive Preview** (Lookbook embed)
5. **Options/Parameters Table** (Complete parameter reference)
6. **Slots Section** (If applicable)
7. **Examples Section** (Multiple scenario embeds)
8. **Customization Section** (Configuration examples)
9. **Dependencies Section** (External dependencies)
10. **Styles Section** (Style configuration display)
11. **References Section** (External documentation links)

## Front Matter Requirements

Every documentation file must start with YAML front matter:

```yaml
---
label: Button
title: Fluxbit::ButtonComponent or fx_button
---
```

### Front Matter Rules

- **label**: Short component name (matches filename)
- **title**: Full component name with both class and helper syntax
- Format: `Fluxbit::ComponentName or fx_helper_name`
- Use exact casing and syntax as shown in examples

## Content Sections

### 1. Component Description

**Format**: Single paragraph explaining what the component is and its primary purpose.

```markdown
The `Fluxbit::ButtonComponent` is a customizable button component that extends `Fluxbit::Component`.
It allows you to create buttons with various styles, sizes, colors, and supports additional
features like popovers and tooltips.
```

**Requirements**:
- Start with "The `Fluxbit::ComponentName` is..."
- Mention it extends the base component
- Briefly describe key features
- Keep to 2-3 sentences maximum

### 2. Basic Usage Examples

**Must include both component and helper syntax**:

```markdown
To start using the button you can use the default way to call the component:

```html
&lt;%= render Fluxbit::ButtonComponent.new.with_content('A button') %&gt;

<!-- or -->

&lt;%= render Fluxbit::ButtonComponent.new do %&gt;
    A button
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_button(with_content: 'A button') %&gt;

<!-- or -->

&lt;%= fx_button do %&gt;
    A button
&lt;% end %&gt;
```
```

**Requirements**:
- Show both `.with_content()` and block syntax
- Include both component class and helper usage
- Use HTML code blocks with escaped ERB syntax
- Use "alias (from the helpers)" wording exactly

### 3. Interactive Preview

**Always include after basic usage**:

```markdown
The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonComponentPreview" scenario="default" panels="params,source"></lookbook-embed>
```

**Format Requirements**:
- Use "The result is:" or "The result look like this:" as lead-in
- Preview path: `Fluxbit::Components::ComponentNamePreview` or `Fluxbit::Typography::ComponentNamePreview`
- Default scenario name: `"default"` or `"playground"`
- Default panels: `"params,source"`

### 4. Options/Parameters Table

**Use consistent table format**:

```markdown
## Options

| Param              | Default  | Description
|:-------------------|:---------|:------------
| color:             | :default | Sets the color scheme of the component, with being the standard color.
| pill:              | false    | If set to true, the component will have rounded corners, giving it a "pill" shape.
| size:              | 1        | Specifies the size of the component. Medium is the default size (e.g., 0 to &lt;%=Fluxbit::Config::ButtonComponent.styles[:size].count - 1 %&gt;).
| as:                | :button  | Change the HTML element, for example, to "a" element.
| remove_class:      | ""       | Classes to be removed from the default class list.
| **props            |          | Additional HTML attributes.
```

**Table Requirements**:
- **Header**: Use "Options" or "Parameters" as section title
- **Columns**: Param, Default, Description (with specific alignment)
- **Parameter Format**: End parameter names with colon (`:`)
- **Default Values**: Use appropriate types (`:symbol`, `false`, `1`, `""`)
- **Dynamic Ranges**: Use ERB syntax for computed values (e.g., size ranges)
- **Catch-all**: Always include `**props` row for additional HTML attributes
- **Inherited Options**: Include popover/tooltip options when applicable

### 5. Slots Section

**Format for components with slots**:

```markdown
## Slots

The component supports the following slots:

- `with_popover`: Add popover title and content with markup.
- `with_tooltip`: Add tooltip content with markup.
- `with_footer`: Add footer content with markup.
```

**Format for components without slots**:

```markdown
## Slots

This component does not define any named slots. The text/content for the heading is provided through the default block:

```html
&lt;%= render Fluxbit::HeadingComponent.new(size: 3) do %&gt;
  This is the heading content
&lt;% end %&gt;
```
```

### 6. Examples Section

**Multiple scenarios with Lookbook embeds**:

```markdown
## Examples

### Default buttons

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonComponentPreview" scenario="default_buttons" panels="source"></lookbook-embed>

### Button pills

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonComponentPreview" scenario="button_pills" panels="source"></lookbook-embed>

### Button sizes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonComponentPreview" scenario="button_sizes" panels="source"></lookbook-embed>
```

**Requirements**:
- Use h3 headings for each example
- Descriptive example names that match Lookbook scenarios
- Generally use `panels="source"` (hide params for examples)
- Cover major component variations and use cases
- Include advanced examples like "Adding/Removing classes" and "Adding other properties"

### 7. Customization Section

**Standard configuration example**:

```markdown
## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_button_component_defaults.rb

Fluxbit::Config::ButtonComponent.color = :danger # the default is :default
Fluxbit::Config::ButtonComponent.pill = true # the default is false
Fluxbit::Config::ButtonComponent.size = 2 # the default is 1
Fluxbit::Config::ButtonComponent.as = :a # the default is :button
Fluxbit::Config::ButtonComponent.styles[:full_sized] = '' # the default is 'w-full'
```
```

**Requirements**:
- Always include initializer file path in comments
- Show examples of changing defaults and styles
- Include comments showing original default values
- Use realistic configuration changes

### 8. Dependencies Section

**Standard format**:

```markdown
## Dependencies

- [**Anyicon**](https://github.com/arthurmolina/anyicon): Used for rendering icons.
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.
```

**Special dependencies when applicable**:

```markdown
## Dependencies

- [**Stimulus Component Notification**](https://www.stimulus-components.com/docs/stimulus-notification): Used for removing the element with animation.
- [**Anyicon**](https://github.com/arthurmolina/anyicon): Used for rendering icons.
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.
```

**Requirements**:
- Use bullet points with linked dependency names
- Always include Tailwind CSS and Flowbite (standard dependencies)
- Include Anyicon when component uses icons
- Add special dependencies as needed (Stimulus controllers, etc.)
- Keep descriptions brief and specific

### 9. Styles Section

**ERB code to display configuration**:

```markdown
## Styles

```ruby
&lt;%= html_escape(JSON.pretty_generate(Fluxbit::Config::ButtonComponent.styles)) %&gt;
```
```

**IMPORTANT EXCEPTIONS**: There are two exceptions to the HTML entity escaping rule:

1. **Styles section ERB code block**: Do NOT escape the `<` and `>` characters in the ERB code block because this code needs to execute properly to display the component configuration. Use `<%= %>` syntax directly without converting to `&lt;%= %&gt;`.

2. **Lookbook embed tags**: Do NOT escape the `<` and `>` characters in `<lookbook-embed>` tags because these are HTML elements that need to render properly. Use `<lookbook-embed>` directly without converting to `&lt;lookbook-embed&gt;`.

**Alternative descriptive format**:

```markdown
## Styles

The component uses Tailwind classes for base, border, focus ring, background, placeholder, and sizing. You can override defaults by subclassing or using `cattr_accessor :styles`.
```

### 10. References Section

**External documentation links**:

```markdown
## References

[Flowbite Buttons](https://flowbite.com/docs/components/buttons/)
```

**Multiple references**:

```markdown
## References

- [Tailwind CSS Typography](https://tailwindcss.com/docs/typography-plugin)
- [Flowbite Components](https://flowbite.com/docs/typography/headings/)
```

## Code Examples and Formatting

### ERB Code Blocks

**CRITICAL RULE: Always use escaped HTML entities in ERB code blocks**:

> **⚠️ IMPORTANT**: All ERB code examples in documentation must use HTML entity escaping. Replace `<` with `&lt;` and `>` with `&gt;` in ALL code blocks that contain ERB syntax. This ensures proper rendering and consistency across all component documentation.

```html
&lt;!-- Correct --&gt;
&lt;%= fx_button do %&gt;
  Click me
&lt;% end %&gt;

&lt;!-- Incorrect --&gt;
&lt;%= fx_button do %&gt;
  Click me
&lt;% end %&gt;
```

### Code Block Languages

- Use `html` for ERB template code
- Use `ruby` for Ruby configuration code
- Use `markdown` for documentation examples

### Comment Formatting

**In code blocks, use standard HTML comments**:

```html
&lt;%= render Fluxbit::ButtonComponent.new.with_content('A button') %&gt;

&lt;!-- or --&gt;

&lt;%= render Fluxbit::ButtonComponent.new do %&gt;
    A button
&lt;% end %&gt;
```

## Lookbook Integration

### Embed Syntax

**Standard format**:

```markdown
<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonComponentPreview" scenario="default" panels="params,source"></lookbook-embed>
```

### Preview Path Conventions

- **UI Components**: `Fluxbit::Components::ComponentNamePreview`
- **Form Components**: `Fluxbit::Forms::ComponentNamePreview` (if separate)
- **Typography**: `Fluxbit::Typography::ComponentNamePreview`

### Panel Options

- **Interactive demos**: `panels="params,source"` (show both parameters and source)
- **Examples**: `panels="source"` (show only source code)
- **Playgrounds**: `panels="params,source"` (full interactivity)

### Scenario Naming

- Use snake_case for scenario names
- Match example section headings
- Common scenarios: `default`, `playground`, `default_buttons`, `button_sizes`, `with_icon`

### Preview File Structure

**CRITICAL REQUIREMENTS**:

1. **ERB Templates REQUIRED**: All preview methods (except `playground`) MUST use HTML ERB templates instead of Ruby code with `content_tag` or `safe_join`
2. **No Groups**: Do NOT use `@!group` annotations in preview files as they affect Lookbook scenario naming and will cause documentation embeds to fail

**Correct preview structure**:

```ruby
class Fluxbit::Components::ComponentNamePreview < ViewComponent::Preview
  # Interactive playground - ONLY method that uses Ruby code
  # @param param [Symbol] select { choices: [option1, option2] }
  def playground(param: :default)
    render ComponentName.new(param: param)
  end

  # All other methods use ERB templates
  def default; end
  def example_1; end
  def example_2; end
  def adding_removing_classes; end
  def adding_other_properties; end
end
```

**ERB Template Structure**:

Create corresponding `.html.erb` files in `previews/fluxbit/components/component_name_preview/`:

```
previews/fluxbit/components/component_name_preview/
├── default.html.erb
├── example_1.html.erb
├── example_2.html.erb
├── adding_removing_classes.html.erb
└── adding_other_properties.html.erb
```

**ERB Template Example**:

```erb
<!-- default.html.erb -->
<%= render ComponentName.new %>

<!-- example_1.html.erb -->
<div class="flex gap-4">
  <% [:option1, :option2, :option3].each do |option| %>
    <div class="flex flex-col items-center gap-2">
      <%= render ComponentName.new(param: option) %>
      <span class="text-sm text-gray-600"><%= option.to_s.humanize %></span>
    </div>
  <% end %>
</div>
```

**Why ERB Templates?**:

1. **Cleaner Code**: ERB templates are much more readable than Ruby `content_tag` methods
2. **Easier Maintenance**: HTML structure is immediately visible and editable
3. **No String Concatenation Errors**: Avoids complex `safe_join` and `+` operator issues
4. **Better Performance**: Templates are compiled and cached by Rails
5. **Familiar Syntax**: Standard ERB syntax that all Rails developers understand
6. **Proper HTML**: Real HTML structure instead of programmatic generation

**Incorrect (avoid groups)**:

```ruby
# DON'T DO THIS - groups break scenario references
class Fluxbit::Components::ComponentNamePreview < ViewComponent::Preview
  # @!group Examples
  def example_1; end
  # @!endgroup
end
```

## Tables and Parameters

### Parameter Table Formatting

**Column alignment**:

```markdown
| Param              | Default  | Description
|:-------------------|:---------|:------------
```

**Parameter naming**:
- Always end with colon (`:`)
- Use snake_case
- Include type information in description when helpful

**Default value formatting**:
- Symbols: `:symbol`
- Booleans: `true`/`false`
- Strings: `"string"`
- Numbers: `1`, `0`
- Nil: `nil`
- Empty: `""`

**Special parameter types**:
- **Catch-all**: `**props` for additional HTML attributes
- **Dynamic ranges**: Use ERB to show computed ranges
- **Inherited**: Include common options like popover/tooltip parameters

## Writing Style Guidelines

### Component Descriptions

- **Active voice**: "The component provides..." not "The component is provided with..."
- **Present tense**: "It allows you to create..." not "It will allow you to create..."
- **Specific features**: Mention key capabilities like "popovers and tooltips"
- **Consistent language**: Use "extends `Fluxbit::Component`" for all components

### Section Introductions

**Standard phrases**:
- "To start using the [component] you can use the default way to call the component:"
- "or you can use the alias (from the helpers):"
- "The result is:" / "The result look like this:"
- "You can customize the appearance and behavior of this component by..."

### Technical Language

- **Component references**: Always use backticks for component names
- **Parameters**: Use colons in parameter names (`color:`, not `color`)
- **Code elements**: Use backticks for classes, methods, attributes
- **File paths**: Use full paths in comments (`# /config/initializers/...`)

### Accessibility and Usability

**Include when relevant**:
- ARIA compliance notes
- Keyboard interaction information
- Screen reader considerations
- Best practice recommendations

## Template and Examples

### Basic Component Documentation Template

```markdown
---
label: ComponentName
title: Fluxbit::ComponentNameComponent or fx_component_name
---

The `Fluxbit::ComponentNameComponent` is a customizable [type] component that extends `Fluxbit::Component`.
It allows you to [brief description of main functionality and key features].

To start using the [component] you can use the default way to call the component:

```html
&lt;%= render Fluxbit::ComponentNameComponent.new.with_content('Content') %&gt;

&lt;!-- or --&gt;

&lt;%= render Fluxbit::ComponentNameComponent.new do %&gt;
    Content
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_component_name(with_content: 'Content') %&gt;

&lt;!-- or --&gt;

&lt;%= fx_component_name do %&gt;
    Content
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ComponentNamePreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param              | Default  | Description
|:-------------------|:---------|:------------
| color:             | :default | Sets the color scheme of the component.
| size:              | 1        | Specifies the size of the component (0 to X).
| remove_class:      | ""       | Classes to be removed from the default class list.
| **props            |          | Additional HTML attributes.

## Slots

[Either describe slots or state "This component does not define any named slots"]

## Examples

### Example 1

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ComponentNamePreview" scenario="example_1" panels="source"></lookbook-embed>

### Example 2

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ComponentNamePreview" scenario="example_2" panels="source"></lookbook-embed>

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_component_name_component_defaults.rb

Fluxbit::Config::ComponentNameComponent.color = :danger # the default is :default
Fluxbit::Config::ComponentNameComponent.size = 2 # the default is 1
```

## Dependencies

- [**Anyicon**](https://github.com/arthurmolina/anyicon): Used for rendering icons.
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
&lt;%= html_escape(JSON.pretty_generate(Fluxbit::Config::ComponentNameComponent.styles)) %&gt;
```

## References

[Flowbite ComponentName](https://flowbite.com/docs/components/component-name/)
```

### Form Component Variations

For form components, include additional sections:

```markdown
## When to use

Use `TextField` whenever you need to collect short or multi-line text from a user. Supports text, email, password, number, and other standard input types.

## Supported Types

`text`, `textarea`, `color`, `number`, `email`, `password`, `search`, `tel`, `url`, `date`, `datetime_local`, `month`, `time`, `week`, `currency`

## Accessibility

* Labels use `<label for="...">` if provided.
* Pass `disabled: true` or `readonly: true` for ARIA compliance.
```

## Quality Checklist

Before publishing component documentation, ensure:

- [ ] Front matter is complete and correctly formatted
- [ ] Component description follows the standard format
- [ ] Both component and helper usage examples are provided
- [ ] Interactive preview embed is included
- [ ] Options table is complete with proper formatting
- [ ] Slots section addresses component's slot usage
- [ ] Multiple examples showcase component capabilities
- [ ] Customization section includes realistic configuration
- [ ] Dependencies are accurately listed with links
- [ ] Styles section displays configuration properly
- [ ] References link to relevant external documentation
- [ ] All ERB code examples use proper HTML entity escaping (`<` → `&lt;`, `>` → `&gt;`)
- [ ] Lookbook embeds use correct preview paths and scenarios
- [ ] Writing follows established tone and style guidelines

This style guide ensures consistent, comprehensive, and user-friendly documentation across all Fluxbit View Components.