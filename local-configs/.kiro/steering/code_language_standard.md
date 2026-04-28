---
inclusion: always
---
# Code Language Standards

## English-Only Code

All code elements must be written in English to ensure international collaboration and maintainability:

- Class names
- Function/method names
- Variable names
- Constants
- File names (for source code)
- Comments and documentation
- Commit messages
- Error messages in logs

## Rationale

Source code may be worked on by developers who don't speak Czech. Using English ensures:
- Universal understanding across the development team
- Better integration with international libraries and frameworks
- Easier code reviews and collaboration
- Standard industry practice

## Exceptions

- User-facing content (HTML text, UI labels, email templates) should remain in Czech
- Configuration values that represent Czech-language content
- Data/content files intended for Czech users

## Examples

✅ Good:
```javascript
const userName = 'Jan';
function sendEmail(recipient, message) { ... }
// Calculate total price including VAT
```

❌ Bad:
```javascript
const jmenoUzivatele = 'Jan';
function odesliEmail(prijemce, zprava) { ... }
// Vypočítat celkovou cenu včetně DPH
```