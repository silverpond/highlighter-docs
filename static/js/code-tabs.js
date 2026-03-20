document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.code-tabs-wrapper').forEach(wrapper => {
    const labels = (wrapper.dataset.tabs || '').split(',').map(s => s.trim()).filter(Boolean);
    const pres = Array.from(wrapper.querySelectorAll('pre'));
    if (pres.length < 2 || labels.length < 2) return;

    // Build nav
    const nav = document.createElement('div');
    nav.className = 'code-tabs__nav';
    nav.setAttribute('role', 'tablist');
    labels.slice(0, pres.length).forEach((label, i) => {
      const btn = document.createElement('button');
      btn.className = 'code-tabs__tab' + (i === 0 ? ' active' : '');
      btn.setAttribute('role', 'tab');
      btn.setAttribute('type', 'button');
      btn.textContent = label;
      nav.appendChild(btn);
    });

    // Build panels — pair each pre with its preceding .doks-clipboard if present
    const content = document.createElement('div');
    content.className = 'code-tabs__content';
    pres.forEach((pre, i) => {
      const panel = document.createElement('div');
      panel.className = 'code-tabs__panel' + (i === 0 ? ' active' : '');
      const prev = pre.previousElementSibling;
      if (prev && prev.classList.contains('doks-clipboard')) {
        panel.appendChild(prev);
      }
      panel.appendChild(pre);
      content.appendChild(panel);
    });

    // Assemble and replace wrapper
    const tabsDiv = document.createElement('div');
    tabsDiv.className = 'code-tabs';
    tabsDiv.appendChild(nav);
    tabsDiv.appendChild(content);
    wrapper.replaceWith(tabsDiv);

    // Wire up click handlers
    const buttons = tabsDiv.querySelectorAll('.code-tabs__tab');
    const panels = tabsDiv.querySelectorAll('.code-tabs__panel');
    buttons.forEach((btn, i) => {
      btn.addEventListener('click', () => {
        buttons.forEach(b => b.classList.remove('active'));
        panels.forEach(p => p.classList.remove('active'));
        btn.classList.add('active');
        if (panels[i]) panels[i].classList.add('active');
      });
    });
  });
});
