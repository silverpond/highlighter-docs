document.addEventListener('DOMContentLoaded', function() {
  document.querySelectorAll('.code-tabs-wrapper').forEach(function(wrapper) {
    var labels = (wrapper.dataset.tabs || '').split(',').map(function(s) { return s.trim(); }).filter(Boolean);
    var pres = Array.from(wrapper.querySelectorAll('pre'));
    if (pres.length < 2 || labels.length < 2) return;

    // Build nav
    var nav = document.createElement('div');
    nav.className = 'code-tabs__nav';
    nav.setAttribute('role', 'tablist');
    labels.slice(0, pres.length).forEach(function(label, i) {
      var btn = document.createElement('button');
      btn.className = 'code-tabs__tab' + (i === 0 ? ' active' : '');
      btn.setAttribute('role', 'tab');
      btn.setAttribute('type', 'button');
      btn.textContent = label;
      nav.appendChild(btn);
    });

    // Build panels — pair each pre with its preceding .doks-clipboard if present
    var content = document.createElement('div');
    content.className = 'code-tabs__content';
    pres.forEach(function(pre, i) {
      var panel = document.createElement('div');
      panel.className = 'code-tabs__panel' + (i === 0 ? ' active' : '');
      var prev = pre.previousElementSibling;
      if (prev && prev.classList.contains('doks-clipboard')) {
        panel.appendChild(prev);
      }
      panel.appendChild(pre);
      content.appendChild(panel);
    });

    // Assemble and replace wrapper
    var tabsDiv = document.createElement('div');
    tabsDiv.className = 'code-tabs';
    tabsDiv.appendChild(nav);
    tabsDiv.appendChild(content);
    wrapper.replaceWith(tabsDiv);

    // Wire up click handlers
    var buttons = tabsDiv.querySelectorAll('.code-tabs__tab');
    var panels = tabsDiv.querySelectorAll('.code-tabs__panel');
    buttons.forEach(function(btn, i) {
      btn.addEventListener('click', function() {
        buttons.forEach(function(b) { b.classList.remove('active'); });
        panels.forEach(function(p) { p.classList.remove('active'); });
        btn.classList.add('active');
        if (panels[i]) panels[i].classList.add('active');
      });
    });
  });
});
