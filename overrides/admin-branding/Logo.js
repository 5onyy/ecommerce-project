import React from 'react';

export default function Logo({ dashboardUrl }) {
  return React.createElement(
    'div',
    { className: 'logo w-9 h-auto flex items-center' },
    React.createElement(
      'a',
      {
        href: dashboardUrl,
        className: 'flex items-center justify-center w-8 h-8'
      },
      React.createElement('img', {
        src: '/assets/images/branding/goalbox-icon-only.jpg',
        alt: 'GoalBox',
        className: 'w-8 h-8 object-contain'
      })
    )
  );
}

export const layout = {
  areaId: 'header',
  sortOrder: 10
};

export const query = `
  query query {
    dashboardUrl: url(routeId:"dashboard")
  }
`;
