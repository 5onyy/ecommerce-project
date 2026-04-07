import React from 'react';

interface LogoProps {
  dashboardUrl: string;
}
export default function Logo({ dashboardUrl }: LogoProps) {
  return (
    <div className="logo w-9 h-auto flex items-center">
      <a href={dashboardUrl} className="flex items-end">
        <svg
          width="40"
          height="40"
          viewBox="0 0 40 40"
          fill="none"
          className="w-8 h-auto"
          xmlns="http://www.w3.org/2000/svg"
        >
          <rect width="40" height="40" rx="12" fill="#10B981" />
          <path
            d="M12 20C12 15.6 15.6 12 20 12H24C28.4 12 32 15.6 32 20C32 24.4 28.4 28 24 28H20C15.6 28 12 24.4 12 20Z"
            fill="white"
            fillOpacity="0.96"
          />
          <circle cx="19" cy="19" r="1.6" fill="#0F766E" />
          <circle cx="25" cy="19" r="1.6" fill="#0F766E" />
          <path
            d="M16 22.5C17.5 24.4 19.6 25.4 22 25.4C24.4 25.4 26.5 24.4 28 22.5"
            stroke="#0F766E"
            strokeWidth="2"
            strokeLinecap="round"
          />
        </svg>
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
