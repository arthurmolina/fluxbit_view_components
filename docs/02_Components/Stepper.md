---
label: Stepper
title: Fluxbit::StepperComponent or fx_stepper
---

The `Fluxbit::StepperComponent` is a customizable stepper component that extends `Fluxbit::Component`.
It provides a visual representation of a multi-step process, supporting both horizontal and vertical orientations
with various styling options including different colors and states.

To start using the stepper you can use the default way to call the component:

```html
&lt;%= render Fluxbit::StepperComponent.new do |stepper| %&gt;
  &lt;% stepper.with_step(title: "Step 1", state: :completed, number: "1") %&gt;
  &lt;% stepper.with_step(title: "Step 2", state: :active, number: "2") %&gt;
  &lt;% stepper.with_step(title: "Step 3", state: :pending, number: "3") %&gt;
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_stepper do |stepper| %&gt;
  &lt;% stepper.with_step(title: "Step 1", state: :completed, number: "1") %&gt;
  &lt;% stepper.with_step(title: "Step 2", state: :active, number: "2") %&gt;
  &lt;% stepper.with_step(title: "Step 3", state: :pending, number: "3") %&gt;
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::StepperComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param              | Default      | Description
|:-------------------|:-------------|:------------
| orientation:       | :horizontal  | The orientation of the stepper (:horizontal, :vertical).
| variant:           | :default     | The variant of the stepper (:default, :progress, :detailed).
| color:             | :blue        | The color theme of the active step (:blue, :green, :red, :yellow, :indigo, :purple).
| remove_class:      | ""           | Classes to be removed from the default class list.
| **props            |              | Additional HTML attributes.

### Step Options

Each step supports the following options:

| Param              | Default      | Description
|:-------------------|:-------------|:------------
| title:             | nil          | The title of the step.
| description:       | nil          | The description text for the step.
| state:             | :pending     | The state of the step (:pending, :active, :completed).
| number:            | nil          | The step number or custom text/icon.

## Slots

The component uses a slot-based approach for steps:

- `with_step`: Add individual steps with customizable titles, descriptions, states, and numbers.

Each step can contain additional content through block syntax.

## Examples

### Default Horizontal Stepper

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::StepperComponentPreview" scenario="default_horizontal" panels="source"></lookbook-embed>

### Vertical Stepper

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::StepperComponentPreview" scenario="vertical_stepper" panels="source"></lookbook-embed>

### Different Colors

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::StepperComponentPreview" scenario="different_colors" panels="source"></lookbook-embed>

### Completed Steps

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::StepperComponentPreview" scenario="completed_steps" panels="source"></lookbook-embed>

### Step States

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::StepperComponentPreview" scenario="step_states" panels="source"></lookbook-embed>

### With Descriptions

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::StepperComponentPreview" scenario="with_descriptions" panels="source"></lookbook-embed>

### Custom Numbers

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::StepperComponentPreview" scenario="custom_numbers" panels="source"></lookbook-embed>

### Progress Variant

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::StepperComponentPreview" scenario="progress_variant" panels="source"></lookbook-embed>

### Detailed Variant

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::StepperComponentPreview" scenario="detailed_variant" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::StepperComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::StepperComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## When to use

Use `Stepper` to visually represent progress through a multi-step process such as:

- **Onboarding flows** - Guide new users through setup steps
- **Multi-step forms** - Break complex forms into manageable sections
- **Checkout processes** - Show progress through cart, shipping, payment, confirmation
- **Workflow visualization** - Display stages in a business process
- **Installation wizards** - Guide users through software setup

## Accessibility

* Steps use semantic `&lt;ol&gt;` and `&lt;li&gt;` elements for proper structure
* Completed steps show checkmark icons with appropriate aria labels
* Active and completed states are visually distinguished
* Component supports ARIA attributes through **props

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_stepper_component_defaults.rb

Fluxbit::Config::StepperComponent.orientation = :vertical # the default is :horizontal
Fluxbit::Config::StepperComponent.variant = :detailed # the default is :default
Fluxbit::Config::StepperComponent.color = :green # the default is :blue

# Customize step styles
Fluxbit::Config::StepperComponent.styles[:step][:base] = 'custom-step-base-classes'
Fluxbit::Config::StepperComponent.styles[:title][:active][:blue] = 'custom-active-title-classes'
```

## Dependencies

- [**Anyicon**](https://github.com/arthurmolina/anyicon): Used for rendering the checkmark icons in completed steps.
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::StepperComponent.styles)) %>
```

## References

[Flowbite Stepper](https://flowbite.com/docs/components/stepper/)