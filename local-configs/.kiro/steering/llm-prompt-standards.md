---
inclusion: always
---

# LLM Prompt Standards

## English-Only Prompts

All LLM prompts (system prompts, user prompts, prompt templates) must be written in English, regardless of the input or output language.

## Rationale

- LLM models have strongest instruction-following in English
- Consistent language across all prompts improves maintainability
- English prompts produce more reliable and predictable outputs
- Any developer can understand and modify the prompts

## Output Language Control

Use explicit instructions within the English prompt to control the output language:

```typescript
// ✅ Good — English prompt, explicit output language
const PROMPT = `You are an expert in dance events.
Analyze the event description and extract structured parts.
Output the generated description in ${targetLanguage}.`;

// ❌ Bad — Czech prompt
const PROMPT = "Analyzuj popis taneční události a vytvoř strukturovaný popis...";
```

## Rules

1. All system prompts must be in English
2. All prompt templates in `prompts.ts` (or equivalent) must be in English
3. Use a `targetLanguage` or `outputLanguage` parameter to control the language of LLM output
4. Never rely on the prompt language to implicitly determine the output language
5. Input text (e.g., event descriptions) can be in any language — the prompt handles it

## Translation Prompts

For translation tasks, use a single parameterized English prompt:

```typescript
const TRANSLATION_PROMPT = `Translate the following text to ${targetLanguage}.
Preserve all proper nouns, dance style names, and formatting.
Return only the translated text.`;
```

## Exceptions

None. All LLM prompts must be in English.
