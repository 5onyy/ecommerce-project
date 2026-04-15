import React from 'react';
import './global.scss';
export default function GlobalCss() {
    React.useEffect(() => {
        if (!document.querySelector('link[href="/goalbox-admin.css"]')) {
            const link = document.createElement('link');
            link.rel = 'stylesheet';
            link.href = '/goalbox-admin.css';
            document.head.appendChild(link);
        }
    }, []);
    return null;
}
export const layout = {
    areaId: 'head',
    sortOrder: 5
};
