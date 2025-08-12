# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## About This Project

This is the public documentation site for Silverpond's Highlighter product - an Enterprise Perception System for AI/ML workflows. The site is built using Zola (a static site generator) and follows the Diátaxis documentation methodology with sections for Concepts, Tutorials, How-To Guides, and Reference materials.

## Development Environment Setup

### Using Nix (Recommended)
- Enter development shell: `nix develop` (automatically installs Zola and Just)
- Alternative: Use direnv with the included `.envrc` file

### Manual Installation
- Install Zola following [their installation guide](https://www.getzola.org/documentation/getting-started/installation/)
- Clone with submodules: `git clone --recurse-submodules <repo-url>`

## Common Development Commands

### Local Development
- **Serve site locally**: `zola serve` (starts development server)
- **Build site**: `zola build` (generates static files in `/public`)

### Content Management
- **Add new documentation**: Create markdown files in `/content/docs/` following existing structure
- **Add images**: Place in `/content/docs/how-to-guides/` or relevant section directory
- **Edit navigation**: Modify menu structure in `config.toml`

## Repository Architecture

### Content Structure (Diátaxis Framework)
- `/content/docs/concepts/` - Explanatory documentation (understanding)
- `/content/docs/tutorials/` - Learning-oriented guides
- `/content/docs/how-to-guides/` - Problem-solving oriented
- `/content/docs/references/` - Information-oriented reference material
- `/content/docs/software-development-kit/` - SDK documentation
- `/content/docs/services/` - Service delivery process documentation

### Key Configuration Files
- `config.toml` - Main Zola configuration (site settings, menus, theme config)
- `netlify.toml` - Deployment configuration for Netlify
- `flake.nix` - Nix development environment definition

### Theme Structure
- Uses the `adidoks` theme located in `/themes/adidoks/`
- Custom styling in theme's SASS files
- Templates in `/themes/adidoks/templates/`

## Content Guidelines

### Terminology Changes
- Recent change from "process" to "workflow" throughout documentation
- When editing, maintain consistency with "assessment workflow" terminology

### Documentation Types
- **Concepts**: Focus on explaining "assessment workflows" and Enterprise Perception System concepts
- **How-To Guides**: Practical instructions for using Highlighter features
- **Tutorials**: Step-by-step learning experiences
- **SDK Documentation**: API references and development guides

### File Naming
- Use descriptive kebab-case filenames
- Include `.md` extension for markdown files
- Place images alongside related markdown files

## Deployment

- **Production**: Auto-deploys to https://highlighter-docs.netlify.app/ when merged to `main`
- **Preview**: Each MR creates a deploy preview URL for review
- **Notifications**: Deploy status sent to #highlighter-docs Slack channel

## Working with Notebooks
- Jupyter notebooks in `/notebooks/` are copied to `/static/notebooks/` and `/public/notebooks/`
- Example: `create_assessments.ipynb` demonstrates API usage

## Search Configuration
- Search index built automatically from page content
- Configuration in `config.toml` under `[search]` section
- Includes page titles and content, excludes descriptions