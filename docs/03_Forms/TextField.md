---
label: TextField
title: Fluxbit::TextFieldComponent or fx_text_field
---

A text input field for forms, with support for labels, helper text, icons, addons, validation states, and all HTML input types.
A flexible form field component for text input, including password, email, number, URL, color, and more. Supports icons, add-ons, multiline (textarea), sizing, and validation colors.

## When to use

Use `TextField` whenever you need to collect short or multi-line text from a user. Supports text, email, password, number, and other standard input types.
It’s suitable for login forms, profile fields, contact forms, and anywhere you’d use a text box or textarea.

## Parameters

| Name         | Type    | Default  | Description                                                    |
| ------------ | ------- | -------- | -------------------------------------------------------------- |
| name         | String  |          | Field name (required unless using a form builder)              |
| label        | String  |          | Text label above the field                                     |
| value        | String  |          | Value for the input                                            |
| placeholder  | String  |          | Placeholder text shown when empty                              |
| type         | Symbol  | :text    | Input type (`:text`, `:email`, `:password`, etc)               |
| multiline    | Boolean | false    | Renders a `<textarea>` if true (or type is `:textarea`)        |
| icon         | Symbol  |          | Left icon (Anyicon name or symbol)                             |
| right_icon   | Symbol  |          | Right icon (Anyicon name or symbol)                            |
| addon        | String  |          | Addon (text or icon) before the field                          |
| color        | Symbol  | :default | State: `:default`, `:success`, `:failure`, `:warning`, `:info` |
| help_text    | String  |          | Help or error text below the field                           |
| sizing       | Symbol  | :md      | `:sm`, `:md`, or `:lg`                                         |
| shadow       | Boolean | false    | Adds a drop shadow if true                                     |
| disabled     | Boolean | false    | Disables the input                                             |
| readonly     | Boolean | false    | Makes the input readonly                                       |
| ...          |         |          | Any other HTML attribute for `<input>`/`<textarea>`            |


## Supported Types

`text`, `textarea`, `color`, `number`, `email`, `password`, `search`, `tel`, `url`, `date`, `datetime_local`, `month`, `time`, `week`, `currency`

## Styling

The component uses Tailwind classes for base, border, focus ring, background, placeholder, and sizing. You can override defaults by subclassing or using `cattr_accessor :styles`.

## Accessibility

* Labels use `<label for="...">` if provided.
* Pass `disabled: true` or `readonly: true` for ARIA compliance.

## Examples

**Basic**

```erb
&lt;%= fx_text_field name: "username", label: "Username" %&gt;
```

**Email field**

```erb
&lt;%= fx_text_field name: "user_email", label: "Email", type: :email, placeholder: "you@example.com" %&gt;
```

**Password field with icon**

```erb
&lt;%= fx_text_field name: "user_password", label: "Password", type: :password, right_icon: :eye %&gt;
```

**With prefix addon**

```erb
&lt;%= fx_text_field name: "price", label: "Price", addon: "$", type: :number %&gt;
```

**Multi-line (textarea)**

```erb
&lt;%= fx_text_field name: "bio", label: "Biography", multiline: true, rows: 4 %&gt;
```

**Validation error**

```erb
&lt;%= fx_text_field name: "email", label: "Email", color: :failure, help_text: "Invalid email address" %&gt;
```


## Previews

* Default
* With icon
* With right icon
* With both icons
* With addon
* With addon and right icon
* Multiline (textarea)
* Disabled
* With helper text
* With error state
* All color variations

See the component previews in Lookbook for all combinations.

## Notes

* Use `type:` for any supported HTML input type (`:text`, `:email`, `:number`, etc).
* Set `multiline: true` or `type: :textarea` for a `<textarea>`.
* If `addon:` is set, left icon is not shown (addon takes its place).
* Supports any HTML input attributes via keyword args.
* Uses Anyicon for icon rendering.



## Basic

```erb
&lt;%= render Fluxbit::Form::TextFieldComponent.new(name: :username, label: "Username") %&gt;
```

### Password

```erb
&lt;%= render Fluxbit::Form::TextFieldComponent.new(name: :password, label: "Password", type: :password) %&gt;
```

### With Icon

```erb
&lt;%= render Fluxbit::Form::TextFieldComponent.new(name: :email, label: "Email", icon: "mail") %&gt;
```

### With Addon

```erb
&lt;%= render Fluxbit::Form::TextFieldComponent.new(name: :amount, label: "Amount", addon: "R$") %&gt;
```

### Disabled

```erb
&lt;%= render Fluxbit::Form::TextFieldComponent.new(name: :readonly, label: "Read only", value: "Not editable", disabled: true) %&gt;
```

### Multiline (Textarea)

```erb
&lt;%= render Fluxbit::Form::TextFieldComponent.new(name: :bio, label: "Bio", multiline: true) %&gt;
```
