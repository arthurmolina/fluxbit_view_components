---
label: Text
title: Fluxbit::TextComponent or fx_txt
---

The **Fluxbit::TextComponent** is a versatile text component that extends **Fluxbit::Component**.
It allows you to style text in various ways (color, background color, size, font weight, text transformations, etc.) 
by leveraging Tailwind CSS classes. Additional HTML attributes (such as `class`, `id`, `data-*`, etc.) can also be passed 
to further control the text’s behavior and styling.

To start using the heading you can you the default way to call the component:

```html
&lt;%= render Fluxbit::TextComponent.new(color: :blue, size: :lg, weight: :bold) do %&gt;
  This text is large, bold, and blue
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_txt(color: :red, size: :sm) do %&gt;
  This text is small and red
&lt;% end %&gt;
```

<lookbook-embed app="/lookbook/" preview="Fluxbit::Typography::TextComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

Below are the main properties that control text styling. You can pass any one (or multiple) of them to customize the text:

| Param                   | Default | Description
|:------------------------|:--------|:-----------
| **color**               | nil     | Controls the text color or applies a gradient to the text if set to one of the gradient options (e.g., `:blue_to_purple`).
| **bg_color**            | nil     | Applies a background color or gradient to the text, wrapping it with `px-2` and rounded corners (like a highlight).
| **size**                | nil     | Controls the font size.
| **weight**              | nil     | Controls the font weight (e.g., `font-bold`).
| **transform**           | nil     | Transforms the text.
| **decoration_line**     | nil     | Adds an underline, overline, or line-through to the text.
| **decoration_type**     | nil     | Changes the style of the text decoration (e.g., dotted underline).
| **decoration_color**    | nil     | Changes the color of the text decoration (underlines, overlines, etc.).
| **decoration_tickness** | nil     | Adjusts the thickness of the text decoration.
| **underline_offset**    | nil     | Adjusts the offset of the text decoration.
| **props**               |         | Additional attributes (e.g., `id: 'title-text'`, or custom classes) can be passed in.

## Customization

You can customize the appearance of this component by passing different parameters and by adding or overriding 
the default styles. For instance, you can create an initializer (e.g., `config/initializers/change_text_component_defaults.rb`) 
to modify the default styles:

```ruby
Fluxbit::Config::TextComponent.styles[:color][:blue] = "text-blue-700 dark:text-blue-400"
Fluxbit::Config::TextComponent.styles[:size][:lg] = "text-lg leading-tight"
# ... etc.
```

You can add new items to the categories or you can create a new category with it's items:

```ruby
Fluxbit::Config::TextComponent.styles[:color][:gray] = "text-gray-700 dark:text-gray-400"
Fluxbit::Config::TextComponent.styles[:any_cat] = {
  cat: "class1 class2",
  # ...
}
# ... etc.
```



## Dependencies

- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::TextComponent.styles)) %>
```

## References

- [Tailwind CSS Typography](https://tailwindcss.com/docs/typography-plugin)
- [Flowbite Components](https://flowbite.com/docs/components/)