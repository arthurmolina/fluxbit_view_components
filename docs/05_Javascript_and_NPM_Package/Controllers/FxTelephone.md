---
label: FxTelephone
title: FxTelephone Controller
---

**Purpose**: Provides automatic phone number masking and formatting based on country-specific patterns. Works in conjunction with the `Fluxbit::Form::TelephoneComponent` to format phone numbers as users type.

## Features
- Automatic phone number masking based on country format
- Dynamic mask switching when country selection changes
- Smart backspace handling for mask characters
- Number-only input validation
- Support for 15 different country phone formats
- Real-time formatting as user types

## Static Values
```javascript
static values = {
  mask: { type: String, default: "(##) #####-####" } // Phone mask pattern (# = digit placeholder)
}
```

## Static Targets
```javascript
static targets = [
  "countrySelect" // The country dropdown element
]
```

## Actions
- `updateMask`: Updates the phone mask when country selection changes

## Mask Format

The mask uses `#` as a placeholder for digits. The controller automatically:
- Inserts mask characters (spaces, dashes, parentheses, etc.) at the correct positions
- Only accepts numeric input for digit positions
- Prevents users from typing more digits than the mask allows

### Example Masks

| Country | Mask | Input | Formatted Output |
|---------|------|-------|------------------|
| Brazil | `(##) #####-####` | `11999998888` | `(11) 99999-8888` |
| USA | `(###) ###-####` | `2025551234` | `(202) 555-1234` |
| UK | `#### ### ####` | `2071234567` | `2071 234 567` |
| Germany | `### #########` | `301234567890` | `030 1234567890` |

## Usage Examples

### Basic Usage with TelephoneComponent

The controller is automatically attached when using `TelephoneComponent`:

```erb
<%= render Fluxbit::Form::TelephoneComponent.new(
  name: "phone",
  label: "Phone Number",
  default_country: "BR"
) %>
```

This generates HTML like:

```html
<div class="flex w-full"
     data-controller="fx-telephone"
     data-fx-telephone-mask-value="(##) #####-####">
  <select data-fx-telephone-target="countrySelect"
          data-action="change->fx-telephone#updateMask">
    <option value="BR" data-mask="(##) #####-####" data-dial-code="+55">🇧🇷 +55</option>
    <!-- more countries -->
  </select>
  <input type="tel" name="phone" />
</div>
```

### Manual Usage (without TelephoneComponent)

```html
<div data-controller="fx-telephone"
     data-fx-telephone-mask-value="(###) ###-####">

  <select data-fx-telephone-target="countrySelect"
          data-action="change->fx-telephone#updateMask">
    <option value="US" data-mask="(###) ###-####">🇺🇸 +1</option>
    <option value="BR" data-mask="(##) #####-####">🇧🇷 +55</option>
  </select>

  <input type="tel" name="phone" placeholder="Enter phone number" />
</div>
```

### Custom Mask Pattern

```html
<div data-controller="fx-telephone"
     data-fx-telephone-mask-value="### ### ###">
  <input type="tel" name="custom_phone" />
</div>
```

### Multiple Phone Inputs

Each input needs its own controller instance:

```html
<!-- Home Phone -->
<div data-controller="fx-telephone"
     data-fx-telephone-mask-value="(##) #####-####">
  <input type="tel" name="home_phone" />
</div>

<!-- Work Phone -->
<div data-controller="fx-telephone"
     data-fx-telephone-mask-value="(##) #####-####">
  <input type="tel" name="work_phone" />
</div>
```

## Behavior Details

### Input Processing

1. **User types**: Only numeric characters are captured
2. **Mask applied**: Numbers are inserted into mask pattern at `#` positions
3. **Non-numeric ignored**: Letters and special characters are filtered out
4. **Length limited**: Input stops when all `#` positions are filled

### Backspace Handling

The controller intelligently handles backspace:

- If cursor is after a mask character (e.g., `)`, `-`, space), it skips to the previous digit
- Deletes the digit, not the mask character
- Reformats the entire number after deletion

Example with Brazilian mask `(##) #####-####`:
```
Input: (11) 99999-8888
Cursor after: (11) 99999-|8888
Press backspace:
Result: (11) 9999-|8888  // Deleted the last 9, not the dash
```

### Country Change

When the user changes the country:

1. Event `change->fx-telephone#updateMask` is triggered
2. Controller reads the `data-mask` attribute from the selected option
3. Updates the `maskValue`
4. Extracts only digits from current input
5. Reapplies new mask to the digits
6. Updates the input field

## Supported Country Formats

The default `TelephoneComponent` includes these masks:

```javascript
const COUNTRY_MASKS = {
  'BR': '(##) #####-####',   // Brazil
  'US': '(###) ###-####',    // United States
  'CA': '(###) ###-####',    // Canada
  'GB': '#### ### ####',     // United Kingdom
  'DE': '### #########',     // Germany
  'FR': '# ## ## ## ##',     // France
  'ES': '### ## ## ##',      // Spain
  'IT': '### ### ####',      // Italy
  'PT': '### ### ###',       // Portugal
  'AR': '## ####-####',      // Argentina
  'MX': '## #### ####',      // Mexico
  'JP': '##-####-####',      // Japan
  'CN': '### #### ####',     // China
  'IN': '##### #####',       // India
  'AU': '### ### ###'        // Australia
}
```

## Methods

### `connect()`
- Finds the `input[type="tel"]` element
- Attaches `input` and `keydown` event listeners
- Called automatically when controller is connected to DOM

### `disconnect()`
- Removes event listeners
- Cleanup when controller is removed from DOM

### `applyMask(event)`
- Main masking function
- Extracts digits from input
- Applies mask pattern
- Updates input value

### `updateMask(event)`
- Triggered on country select change
- Reads new mask from option's `data-mask`
- Reapplies mask to current value

### `handleBackspace(event)`
- Intercepts backspace key
- Skips over mask characters
- Deletes actual digits

### `getCleanValue(value)`
- Removes all non-numeric characters
- Returns only digits

### `isMaskCharacter(char)`
- Checks if character is a mask symbol
- Returns `true` for: space, dash, parentheses, slash, dot

## Integration Notes

### Form Submission

The masked value is submitted as-is. For server-side processing:

```ruby
# Rails controller
def phone_params
  params.require(:user).permit(:phone, :phone_country)
end

# Clean the phone number
def clean_phone(phone)
  phone.gsub(/\D/, '') # Remove all non-digits
end

# Usage
user.phone = clean_phone(params[:user][:phone])
```

### Validation

Client-side validation happens automatically through masking. For server-side:

```ruby
# app/models/user.rb
validates :phone, format: {
  with: /\A\d{10,15}\z/,
  message: "must be a valid phone number"
}

before_validation :clean_phone

private

def clean_phone
  self.phone = phone.gsub(/\D/, '') if phone.present?
end
```

### Accessibility

The controller maintains accessibility:
- Input type remains `tel` for mobile keyboard
- Screen readers announce the formatted value
- No interference with keyboard navigation

## Troubleshooting

### Mask not applying

Check that:
1. Controller is registered: `application.register('fx-telephone', FxTelephone)`
2. `data-controller="fx-telephone"` is on parent element
3. Input has `type="tel"`
4. Mask value is set: `data-fx-telephone-mask-value="pattern"`

### Country change not working

Verify:
1. Select has `data-fx-telephone-target="countrySelect"`
2. Select has `data-action="change->fx-telephone#updateMask"`
3. Options have `data-mask="pattern"` attributes

### Input accepts letters

This is expected behavior - the controller filters them out automatically. Only numbers will appear in the formatted output.

## Browser Compatibility

- Modern browsers (Chrome, Firefox, Safari, Edge)
- Requires ES6 support (class syntax, template literals)
- Works with mobile browsers (iOS Safari, Chrome Mobile)
