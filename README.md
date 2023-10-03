# Highlighter Public Documentation

This repo contains public documentation for Silverpond's Highlighter product.

See /content folder for details.

This documentation site uses Zola to generate a static website. Follow their [installation page](https://www.getzola.org/documentation/getting-started/installation/) to install Zola and get started. For ease of use, there's a [justfile](https://github.com/casey/just) for common Zola actions.

Or you can use flakes (eg., `nix develop` or direnv (.envrc) to install Zola and setup the environment.

# Documentation Style

This documentation site follows the [Diátaxis](https://diataxis.fr/) method of documentation:
  * Concepts (for explanation and learning)
  * Getting Started and Tutorials sections (to be developed)
  * How-To Guide section (to be developed)
  * Reference (to be developed)

### Deployment
[![Netlify Status](https://api.netlify.com/api/v1/badges/9b184225-5c69-4c91-8c19-5c6104c96108/deploy-status)](https://app.netlify.com/sites/highlighter-docs/deploys)

The static website is deployed via [Netlify](https://netlify.app/), following Zola's [instructions](https://www.getzola.org/documentation/deployment/netlify/):
* The site is deployed to [https://highlighter-docs.netlify.app/](https://highlighter-docs.netlify.app/) when MRs are merged to `main` in [Github](https://github.com/silverpond/highlighter-docs).
* Each MR will will create a [Deploy Preview URL for review](https://docs.netlify.com/site-deploys/deploy-previews/)
* Deploys are added as comments to a Github MR
* Deploy notifications are sent via slack to #highlighter-docs

### Working with the Repo

Clone the repo including submodules.

Enter a dev shell via `nix develop`

Serve the site locally in development mode via `zola serve`

Update content in /content and create an MR.
