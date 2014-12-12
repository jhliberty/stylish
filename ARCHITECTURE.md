# Stylish.io Architecture

Below are some descriptions of the various parts of the Stylish domain:

### Library

A library is a collection of packages. A library may be persisted on
disk, locally, or in a remote github repository.

The stylish developer server sits on top of a library, providing access
to the packages it contains, and the means of working with or previewing 
those packages.

### Package

A package is a theme, a collection of components, and the supporting
scripts, stylesheets, templates, and documentation.

### Manifest

The manifest describes where various files are stored that contain the
code for the components, scripts, stylesheets, etc.

### Theme

A theme is a collection of stylesheets, along with specific values of
preprocessor configuration variables. A package has at least one theme,
and a theme can be said to inherit from a package.  In this way, a theme
can override or extend the defaults provided by a package.

### Component

A component is an HTML snippet, which depends on external script, or
stylesheet assets.

### Layout

A layout is a collection of components, arranged in HTML form, with
accompanying CSS.

### Script

A script belongs to a package, and powers a component or a layout.

### Stylesheet

A stylesheet belongs to a package, and powers a component or a layout.

### Template

A Template is a component's HTML, along with a mapping of CSS selectors
to field names.  This allows us to apply transformations to HTML
snippets to output them in different templating languages.

Example:

We start with this generic, static HTML snippet, for a landing page
block.

```html
<div class="hero">
  <h1 class="main-heading"></h1>
  <h2 class="sub-heading"></h2>
</div>
```

To templatize this HTML snippet, we can take a configuration structure
like such:

```yaml
---
template_name: Hero snippet
mappings:
  main_heading: ".hero .main-heading"
  sub_heading: ".hero .sub-heading"
```

and this will allow us to generate an ERB template:

```erb
<div class="hero">
  <h1 class="main-heading"><%= data.main_heading %></h1>
  <h2 class="sub-heading"><%= data.sub_heading %></h1>
</div>
```

or a Slim template:

```slim
.hero
  h1.main-heading= data.main_heading
  h2.sub-heading= data.sub_heading
```

or whatever else we want to use, all while enabling the theme designer
to use standard HTML to author their example components.
