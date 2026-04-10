import React from 'react';

interface LogoProps {
  dashboardUrl: string;
}
export default function Logo({ dashboardUrl }: LogoProps) {
  return (
    <div className="logo w-9 h-auto flex items-center">
      <a href={dashboardUrl} className="flex items-end">
        <img
          src="/assets/images/branding/goalbox-app-icon-square.jpg"
          alt="GoalBox Admin"
          width="32"
          height="32"
          className="w-8 h-8 rounded-md object-cover"
        />
      </a>
    </div>
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
