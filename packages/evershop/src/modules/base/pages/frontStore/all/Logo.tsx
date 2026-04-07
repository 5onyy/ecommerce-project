import React from 'react';

interface LogoProps {
  themeConfig: {
    logo: {
      src?: string;
      alt?: string;
      width?: number;
      height?: number;
    };
  };
}
export default function Logo({
  themeConfig: {
    logo: { src, alt = 'GoalBox', width = 128, height = 128 }
  }
}: LogoProps) {
  return (
    <div className="logo md:ml-0 flex justify-center items-center">
      {src && (
        <a href="/" className="logo-icon">
          <img src={src} alt={alt} width={width} height={height} />
        </a>
      )}
      {!src && (
        <a href="/" className="logo-icon inline-flex items-center gap-2">
          <svg
            width="40"
            height="40"
            viewBox="0 0 40 40"
            fill="none"
            className="w-10 h-10"
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
          <span className="text-lg font-semibold text-[#0F172A]">GoalBox</span>
        </a>
      )}
    </div>
  );
}

export const layout = {
  areaId: 'headerMiddleCenter',
  sortOrder: 10
};

export const query = `
  query query {
    themeConfig {
      logo {
        src
        alt
        width
        height
      }
    }
  }
`;
