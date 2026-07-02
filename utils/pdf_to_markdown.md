# PDF to Markdown Converter

There are several ways to convert PDF to Markdown. If the PDF is **text-based**, you can use the following methods, the `markitdown` command-line tool, or the `pandoc` command-line tool.

```bash
markitdown input.pdf -o output.md
```

when the PDF is **image-based**, you can use the `ocrmypdf` command-line tool to convert the PDF to text-based PDF, then use the `markitdown` command-line tool to convert the text-based PDF to Markdown. If need support the chinese language, you can use the `ocrmypdf` with the `--language` option. need `brew install tesseract-lang` to install the language package.

```bash
ocrmypdf --language chi_sim --jobs 16 input.pdf output.pdf
markitdown output.pdf -o output.md
```
