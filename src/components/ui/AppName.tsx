import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import React from 'react';

export default function AppName() {
  const { siteConfig } = useDocusaurusContext();

  return <span>{siteConfig.title}</span>;
}
